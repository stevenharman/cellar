require 'brewery_db'

class Warehouse

  def initialize(brewery_db_api_key = ENV['BREWERY_DB_API_KEY'])
    @client = BreweryDB::Client.new do |c|
      c.api_key = brewery_db_api_key
    end
  end

  def breweries
    @client.breweries.all
  end

  def categories
    @client.categories.all
  end

  def styles
    @client.styles.all
  end
end
