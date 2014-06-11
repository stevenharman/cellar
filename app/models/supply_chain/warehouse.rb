require 'service_keys'
require 'brewery_db'

module SupplyChain
  class Warehouse

    def initialize(brewery_db_api_key: ServiceKeys.brewery_db, client_factory: BreweryDB::Client)
      @client = client_factory.new do |c|
        c.api_key = brewery_db_api_key
      end
    end

    def breweries
      Array(@client.breweries.all)
    end

    def brewery(id)
      @client.breweries.find(id)
    end

    def categories
      Array(@client.categories.all)
    end

    def styles
      Array(@client.styles.all)
    end

    def sizes
      Array(@client.fluid_size.all)
    end

    def brews_for_brewery(brewery_id)
      Array(@client.brewery(brewery_id).beers)
    end

    def brew(id)
      @client.beers.find(id, withBreweries: 'Y')
    end

    def availabilities
      Array(@client.menu.beer_availability)
    end
  end
end
