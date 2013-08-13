require_relative 'log'
require_relative 'brew_catalog_order'
require_relative 'translator'
require_relative 'brew_translation'
require_relative 'brewery_translation'
require_relative 'category_translation'
require_relative 'style_translation'
require_relative 'job/fetch_brew_catalog'
require_relative '../brew'
require_relative '../availability'
require_relative '../brewery'
require_relative '../category'
require_relative '../size'
require_relative '../style'

module SupplyChain
  class Agent

    def self.import_from(warehouse)
      new(warehouse).import_full_inventory
    end

    def initialize(warehouse, log = SupplyChain::Log.new)
      @warehouse = warehouse
      @log = log
    end

    def import_full_inventory
      reset_warehouse_status

      import_reference_data
      import_breweries do |brewery|
        order = BrewCatalogOrder.new(brewery.brewery_db_id)
        Job::FetchBrewCatalog.fulfill(order)
      end
    end

    def import_reference_data
      import_categories
      import_styles
      import_sizes
      import_availabilities
    end

    def import_breweries
      @warehouse.breweries.each do |b|
        brewery = Translator.new(BreweryTranslation, ::Brewery).translate(b)
        @log.record(brewery)
        yield brewery if block_given?
        brewery
      end
    end

    def import_brewery(id)
      raw_data = @warehouse.brewery(id)
      brewery = Translator.new(BreweryTranslation, ::Brewery).translate(raw_data)
      @log.record(brewery)
    end

    def import_brew(id)
      raw_data = @warehouse.brew(id)
      brew = Translator.new(BrewTranslation, ::Brew).translate(raw_data)
      @log.record(brew)
    end

    private

    def import_categories
      @warehouse.categories.map do |c|
        category = Translator.new(CategoryTranslation, ::Category).translate(c)
        @log.record(category)
      end
    end

    def import_styles
      @warehouse.styles.map do |s|
        style = Translator.new(StyleTranslation, ::Style).translate(s)
        @log.record(style)
      end
    end

    def import_availabilities
      @warehouse.availabilities.map do |a|
        availability = Translator.new(AvailabilityTranslation, ::Availability).translate(a)
        @log.record(availability)
      end
    end

    def import_sizes
      @warehouse.sizes.map do |s|
        size = Translator.new(SizeTranslation, ::Size).translate(s)
        @log.record(size)
      end
    end

    def reset_warehouse_status
      ::Brewery.update_all(brewery_db_status: 'unknown')
      ::Brew.update_all(brewery_db_status: 'unknown')
    end
  end
end
