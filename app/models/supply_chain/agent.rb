
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
      import_styles_with_categories
      import_breweries do |brewery|
        FetchBrewCatalog.process(brewery)
      end
    end

    def import_styles_with_categories
      import_categories
      import_styles
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
  end
end
