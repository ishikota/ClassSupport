class User < ActiveRecord::Base
  before_save { student_id.downcase! }
  validates :name, presence:true, length:{ maximum:50 }
  VALID_STUDENTID_REGEX = /[a-zA-Z]\d{7}/
  validates :student_id, presence:true, length:{ is:8 },
            format:{ with:VALID_STUDENTID_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length:{ minimum:6 }
end
