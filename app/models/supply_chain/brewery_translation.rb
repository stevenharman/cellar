require_relative 'conversions'

module SupplyChain
  class BreweryTranslation < Struct.new(:brewery)
    include SupplyChain::Conversions

    def call(raw_data)
      brewery.name = raw_data.name
      brewery.description = raw_data.description
      brewery.established = year(raw_data.established)
      brewery.organic = boolean(raw_data.is_organic)
      brewery.website = raw_data.website
      brewery.brewery_db_status = raw_data.status

      images = images(raw_data.images)
      brewery.icon = images.icon
      brewery.medium_image = images.medium
      brewery.large_image = images.large

      brewery.save
      brewery
    end

  end
end
