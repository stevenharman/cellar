require_relative 'category_snapshot'
require_relative 'brewery_snapshot'
require_relative 'inventory_log'

class StockBoy

  def initialize(warehouse, log = InventoryLog.new)
    @warehouse = warehouse
    @log = log
  end

  def inventory
    @warehouse.categories.each do |c|
      category = CategorySnapshot.stock(c)
      @log.record(category)
    end

    @warehouse.breweries.each do |b|
      brewery =  BrewerySnapshot.stock(b)
      @log.record(brewery)
    end
  end

end
