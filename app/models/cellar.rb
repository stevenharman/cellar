require_relative 'beer_order_receipt'

class Cellar
  attr_reader :keeper

  def initialize(user, brew_master=BrewMaster)
    @keeper = user
    @brew_master = brew_master
  end

  def stock_beer(order)
    new_beers = @brew_master.process(order)
    cellared_beers = add_to_cellar(new_beers)
    ensure_successfully_cellared(cellared_beers)
    BeerOrderReceipt.new(cellared_beers)
  end

  def stocked_brews
    keeper.stocked_brews
  end

  def find_beer(id)
    keeper.find_beer(id)
  end

  def beers_for(brew)
    keeper.stocked_beers(brew)
  end

  def kept_by?(other_user)
    keeper == other_user
  end

  private

  def add_to_cellar(beers)
    beers.collect do |beer|
      beer.user = keeper
      beer.save
      beer
    end
  end

  def ensure_successfully_cellared(beers)
    cancel!(beers) unless beers.all?(&:valid?)
  end

  def cancel!(beers)
    beers.map { |beer| beer.destroy }
  end

end
