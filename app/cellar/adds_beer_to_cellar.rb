class AddsBeerToCellar

  def initialize(order)
    @beer_order = order
    @brew = Brew.find_by_id(order.brew_id)
  end

  def fulfill
    new_beers = make_beers(@beer_order.beers)
    BeerOrderReceipt.new(new_beers, @brew)
  end

  private

  def make_beers(beers)
    beers.each do |beer_stuff|
      Beer.create(beer_stuff) { |b| b.brew = @brew }
    end
  end
end
