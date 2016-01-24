module UsersHelper

  def gravatar_for(user, options = { size:80 })
    raise "wwawa" if user.student_id.nil?
    gravatar_id = Digest::MD5::hexdigest(user.student_id.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alg:user.name, class:"gravatar")
  end

end
