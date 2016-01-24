class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { student_id.downcase! }
  validates :name, presence:true, length:{ maximum:50 }
  VALID_STUDENTID_REGEX = /[a-zA-Z]\d{7}/
  validates :student_id, presence:true, length:{ is:8 },
            format:{ with:VALID_STUDENTID_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length:{ minimum:6 }, allow_nil:true

  # 与えられた文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # 渡されたトークン(永続Cookieに保存)が,ダイジェスト(DBに保存された値)と一致したらtrueを返す．
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
