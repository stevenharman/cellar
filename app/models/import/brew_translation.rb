module Import
  class BrewTranslation

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(brew, brewery_factory = ::Brewery)
      @brew = brew
      @brew_factory = brew_factory
      @brewery = brewery_factory.find_by_brewery_db_id(brew.brewery_db_id)
    end

    def translate(raw_data)
      @brew.tap do |b|
        b.brewery = @brewery
        b.name = raw_data.name
        b.description = raw_data.description
        b.style_id = raw_data.style_id
        b.base_brew_id = raw_data.beer_variation_id
        b.organic = WarehouseMap.boolean(raw_data.is_organic)
        b.year = WarehouseMap.year(raw_data.year)
        b.abv = WarehouseMap.decimal(raw_data.abv)
        b.ibu = WarehouseMap.decimal(raw_data.ibu)
        b.original_gravity = WarehouseMap.decimal(raw_data.original_gravity)

        labels = WarehouseMap.images(raw_data.labels)
        b.icon = labels.icon
        b.medium_image = labels.medium
        b.large_image = labels.large
      end

      @brew.save!
      @brew
    end

  end
end
