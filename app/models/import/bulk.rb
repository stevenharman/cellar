require_relative 'category'
require_relative 'style'
require_relative 'brewery'
require_relative 'brew_catalog'
require_relative 'log'

module Import
  class Bulk

    def self.import_from(warehouse)
      new(warehouse).perform
    end

    def initialize(warehouse, log = Import::Log.new)
      @warehouse = warehouse
      @log = log
    end

    def perform
      import_categories
      import_styles
      import_breweries do |brewery|
        Import::BrewCatalog.import_from(brewery)
      end
    end

    private

    def import_categories
      @warehouse.categories.map do |c|
        category = Import::Category.import(c)
        @log.record(category)
      end
    end

    def import_styles
      @warehouse.styles.map do |s|
        style = Import::Style.import(s)
        @log.record(style)
      end
    end

    def import_breweries
      @warehouse.breweries.each do |b|
        brewery = Import::Brewery.import(b)
        @log.record(brewery)
        yield brewery if block_given?
        brewery
      end
    end

  end
end
