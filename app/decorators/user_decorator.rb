require 'gravatar'

class UserDecorator < ApplicationDecorator
  delegate_all

  def gravatar(size = 64)
    g = Gravatar.new(email, default_image: 'blank', size: size)
    h.image_tag(g.url, alt: username, class: 'avatar')
  end

end
