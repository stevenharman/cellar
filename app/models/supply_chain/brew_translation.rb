require_relative 'conversions'

module SupplyChain
  class BrewTranslation
    include SupplyChain::Conversions

    attr_reader :brew, :warehouse_map

    def initialize(brew, warehouse_map = WarehouseMap.new)
      @brew = brew
      @warehouse_map = warehouse_map
    end

    def call(raw_data)
      brew.name = raw_data.name
      brew.description = raw_data.description
      brew.organic = boolean(raw_data.is_organic)
      brew.year = year(raw_data.year)
      brew.abv = decimal(raw_data.abv)
      brew.ibu = decimal(raw_data.ibu)
      brew.original_gravity = decimal(raw_data.original_gravity)
      brew.brewery_db_status = raw_data.status

      labels = images(raw_data.labels)
      brew.icon = labels.icon
      brew.medium_image = labels.medium
      brew.large_image = labels.large

      base_brew_id = raw_data.beer_variation_id
      brew.base_brew = find_brew(base_brew_id)
      ensure_base_brew(brew, base_brew_id)

      brew.availability = find_availability(raw_data.available_id)
      brew.style = find_style(raw_data.style_id)

      brew.breweries << new_breweries(raw_data.breweries)

      brew.save!
      brew
    end

    private

    def ensure_base_brew(brew, base_brew_id)
      fail BrewMissingError, base_brew_id if brew.base_brew.nil? && base_brew_id
    end

    def new_breweries(breweries)
      ids = Array(breweries).map(&:id)
      all_breweries = find_breweries(ids)
      all_breweries - brew.breweries
    end

    def find_availability(id)
      warehouse_map.find_availability(id)
    end

    def find_brew(id)
      warehouse_map.find_brew(id)
    end

    def find_breweries(ids)
      warehouse_map.find_breweries(ids)
    end

    def find_style(id)
      warehouse_map.find_style(id)
    end

  end
end
