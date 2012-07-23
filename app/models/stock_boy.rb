require_relative 'brewery_snapshot'

class StockBoy

  def initialize(warehouse)
    @warehouse = warehouse
  end

  def inventory
    @warehouse.breweries.each do |b|
      BrewerySnapshot.stock(b)
    end
  end

end
