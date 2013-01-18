require 'digest/md5'

class UserDecorator < ApplicationDecorator
  delegate_all

  def gravatar(size = 32)
    hashed_email = Digest::MD5.hexdigest(email)
    h.image_tag("https://secure.gravatar.com/avatar/#{hashed_email}.png?size=#{size}x#{size}",
                alt: username, class: 'gravatar')
  end
end
