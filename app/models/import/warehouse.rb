require 'brewery_db'

module Import
  class Warehouse

    def initialize(brewery_db_api_key = ENV['BREWERY_DB_API_KEY'])
      @client = BreweryDB::Client.new do |c|
        c.api_key = brewery_db_api_key
      end
    end

    def brew(id)
      @client.beers.find(id)
    end

    def breweries
      Array(@client.breweries.all)
    end

    def categories
      Array(@client.categories.all)
    end

    def styles
      Array(@client.styles.all)
    end

    def brews_for_brewery(brewery_id)
      Array(@client.brewery(brewery_id).beers)
    end
  end
end
