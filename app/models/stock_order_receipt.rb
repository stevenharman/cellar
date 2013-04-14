class StockOrderReceipt

  def initialize(beers)
    @beers = beers
  end

  def example_beer
    @example_beer ||= @beers.first
  end

  def errors
    example_beer.errors
  end

  def error_messages
    errors.full_messages
  end

  def valid?
    @beers.all?(&:valid?)
  end

end
