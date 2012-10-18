class BeerOrderReceipt

  def initialize(beers)
    @beers = beers
  end

  def example_beer
    @example_beer ||= @beers.first
  end

  def brew_name
    brew.name
  end

  def error_messages
    example_beer.errors.full_messages
  end

  def success?
    @beers.all?(&:valid?)
  end

  private

  def brew
    @brew ||= example_beer.brew
  end

end
