module Import
  class Brew

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(raw_data, brew_factory = ::Brew, brewery_factory = ::Brewery)
      @raw_data = raw_data
      @brew_factory = brew_factory
      @brew = find_or_initialize(raw_data.id)
      @brewery = brewery_factory.find_by_brewery_db_id(raw_data.brewery_id)
    end

    def import
      @brew.tap do |b|
        b.brewery = @brewery
        b.name = @raw_data.name
        b.description = @raw_data.description
        b.style_id = @raw_data.style_id
        b.base_brew_id = @raw_data.beer_variation_id
        b.organic = WarehouseMap.boolean(@raw_data.is_organic)
        b.year = WarehouseMap.year(@raw_data.year)
        b.abv = WarehouseMap.decimal(@raw_data.abv)
        b.ibu = WarehouseMap.decimal(@raw_data.ibu)
        b.original_gravity = WarehouseMap.decimal(@raw_data.original_gravity)

        labels = WarehouseMap.images(@raw_data.labels)
        b.icon = labels.icon
        b.medium_image = labels.medium
        b.large_image = labels.large
      end

      @brew.save!
      @brew
    end

    private

    def find_or_initialize(brewery_db_id)
      brewery = @brew_factory.find_by_brewery_db_id(brewery_db_id)
      brewery || @brew_factory.new.tap { |b| b.brewery_db_id = brewery_db_id }
    end

  end
end
