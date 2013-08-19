require 'digest/md5'

class UserDecorator < ApplicationDecorator
  delegate_all

  def gravatar(size = 64)
    hashed_email = Digest::MD5.hexdigest(email)
    default_image = h.image_url('default-avatar.png')
    h.image_tag("https://secure.gravatar.com/avatar/#{hashed_email}.png?size=#{size}x#{size}&d=#{default_image}",
                alt: username, class: 'avatar')
  end
end
