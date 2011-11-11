class AddsBeerToCellar

  def initialize(order)
    @beer_order = order
    @brew = Brew.find_by_id(order.brew_id)
  end

  def fulfill
    new_beers = make_beers(@beer_order.beers)
    ensure_all_valid(new_beers)
    BeerOrderReceipt.new(new_beers)
  end

  private

  def make_beers(beers)
    beers.collect do |beer_stuff|
      Beer.create(beer_stuff) { |b| b.brew = @brew }
    end
  end

  def ensure_all_valid(beers)
    cancel!(beers) unless beers.all?(&:valid?)
  end

  def cancel!(beers)
    beers.map { |b| b.delete }
  end
end
