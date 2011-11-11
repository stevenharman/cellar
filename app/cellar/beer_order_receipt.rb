class BeerOrderReceipt

  def initialize(beers)
    @beers = beers
  end

  def example_beer
    @beers.first
  end

  def success?
    @beers.all?(&:valid?)
  end

end
