class AnonymousUser
  attr_reader :username

  def active?
    false
  end

  def cellared_beers(brew = nil)
    # Rails 4: use Beer.none
    Beer.where(id: nil).where("id IS NOT ?", nil)
  end
end
