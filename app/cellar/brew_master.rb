class BrewMaster

  def self.process(order)
   brew = Brew.find_by_id(order.brew_id)
   make_beers(order.beers, brew)
  end

  private

  def self.make_beers(beer_stuffs, brew)
    beer_stuffs.collect { |bs| Beer.make(bs, brew) }
  end

end
