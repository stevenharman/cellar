class Cellar

  def initialize(user)
    @user = user
  end

  def stock_beer(order)
    new_beers = BrewMaster.process(order)
    cellared_beers = add_to_cellar(new_beers)
    ensure_successfully_cellared(cellared_beers)
    BeerOrderReceipt.new(cellared_beers)
  end

  private

  def add_to_cellar(beers)
    beers.collect do |beer|
      beer.user = @user
      beer.save
      beer
    end
  end

  def ensure_successfully_cellared(beers)
    cancel!(beers) unless beers.all?(&:valid?)
  end

  def cancel!(beers)
    beers.map { |beer| beer.delete }
  end

end
