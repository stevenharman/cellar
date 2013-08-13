require_relative 'conversions'

module SupplyChain
  class BreweryTranslation
    include SupplyChain::Conversions

    def initialize(brewery)
      @brewery = brewery
    end

    def translate(raw_data)
      @brewery.tap do |b|
        b.name = raw_data.name
        b.description = raw_data.description
        b.established = year(raw_data.established)
        b.organic = boolean(raw_data.is_organic)
        b.website = raw_data.website
        b.brewery_db_status = raw_data.status

        images = images(raw_data.images)
        b.icon = images.icon
        b.medium_image = images.medium
        b.large_image = images.large
      end

      @brewery.save
      @brewery
    end

  end
end
