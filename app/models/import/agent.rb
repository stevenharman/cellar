require_relative 'category'
require_relative 'style'
require_relative 'brewery'
require_relative 'brew_catalog'
require_relative 'log'

module Import
  class Agent

    def self.import_from(warehouse)
      new(warehouse).import_full_inventory
    end

    def initialize(warehouse, log = Import::Log.new)
      @warehouse = warehouse
      @log = log
    end

    def import_full_inventory
      import_styles_with_categories
      import_breweries do |brewery|
        Import::BrewCatalog.import_from(brewery)
      end
    end

    def import_styles_with_categories
      import_categories
      import_styles
    end

    def import_breweries
      @warehouse.breweries.each do |b|
        brewery = Import::Brewery.import(b)
        @log.record(brewery)
        yield brewery if block_given?
        brewery
      end
    end

    def import_brewery(id)
      brewery = Import::Brewery.import(@warehouse.brewery(id))
      @log.record(brewery)
    end

    def import_brew(id)
      brew = Import::Brew.import(@warehouse.brew(id))
      @log.record(brew)
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
  end
end
