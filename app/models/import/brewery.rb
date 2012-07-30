require_relative '../warehouse_map'

module Import
  class Brewery

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(raw_data, brewery_catalog = Brewery)
      @raw_data = raw_data
      @brewery_catalog = brewery_catalog
      @brewery = find_or_initialize(raw_data.id)
    end

    def import
      @brewery.tap do |b|
        b.name = @raw_data.name
        b.description = @raw_data.description
        b.established = WarehouseMap.year(@raw_data.established)
        b.organic = WarehouseMap.boolean(@raw_data.is_organic)
        b.website = @raw_data.website

        images = WarehouseMap.images(@raw_data.images)
        b.icon = images.icon
        b.medium_image = images.medium
        b.large_image = images.large
      end

      @brewery.save
      @brewery
    end

    private

    def find_or_initialize(brewery_db_id)
      brewery = @brewery_catalog.find_by_brewery_db_id(brewery_db_id)
      brewery || @brewery_catalog.new.tap { |b| b.brewery_db_id = brewery_db_id }
    end

  end
end
