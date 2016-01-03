module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.student_id.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alg:user.name, class:"gravatar")
  end

end
