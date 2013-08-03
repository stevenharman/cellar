class AnonymousUser
  attr_reader :username

  def active?
    false
  end

  def cellared_beers(brew = nil)
    Beer.none
  end
end
