require_relative 'category_snapshot'
require_relative 'style_snapshot'
require_relative 'brewery_snapshot'
require_relative 'inventory_log'

class StockBoy

  def initialize(warehouse, log = InventoryLog.new)
    @warehouse = warehouse
    @log = log
  end

  def inventory
    stock_categories
    stock_styles
    stock_breweries
  end

  private

  def stock_categories
    @warehouse.categories.map do |c|
      category = CategorySnapshot.stock(c)
      @log.record(category)
    end
  end

  def stock_styles
    @warehouse.styles.map do |s|
      style = StyleSnapshot.stock(s)
      @log.record(style)
    end
  end

  def stock_breweries
    @warehouse.breweries.each do |b|
      brewery =  BrewerySnapshot.stock(b)
      @log.record(brewery)
      yield brewery if block_given?
      brewery
    end
  end

end
