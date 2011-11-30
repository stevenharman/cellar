require_relative 'beer_order_receipt'

class Cellar
  attr_reader :user

  def initialize(user, brew_master=BrewMaster, fetches_brews=Brew)
    @user = user
    @fetches_brews = fetches_brews
    @brew_master = brew_master
  end

  def stock_beer(order)
    new_beers = @brew_master.process(order)
    cellared_beers = add_to_cellar(new_beers)
    ensure_successfully_cellared(cellared_beers)
    BeerOrderReceipt.new(cellared_beers)
  end

  def stocked_brews
    @fetches_brews.from_cellar(user)
  end

  private

  def add_to_cellar(beers)
    beers.collect do |beer|
      beer.user = user
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
