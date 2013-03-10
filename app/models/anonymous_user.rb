require 'models/beer'

class AnonymousUser
  attr_reader :username

  def active?
    false
  end

  def cellared_beers
    # Rails 4: use Beer.none
    Beer.where(false)
  end
end
