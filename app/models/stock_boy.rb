require_relative 'import/category'
require_relative 'import/style'
require_relative 'import/brewery'
require_relative 'import/log'

class StockBoy

  def initialize(warehouse, log = Import::Log.new)
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
      category = Import::Category.import(c)
      @log.record(category)
    end
  end

  def stock_styles
    @warehouse.styles.map do |s|
      style = Import::Style.import(s)
      @log.record(style)
    end
  end

  def stock_breweries
    @warehouse.breweries.each do |b|
      brewery = Import::Brewery.import(b)
      @log.record(brewery)
      yield brewery if block_given?
      brewery
    end
  end

end
