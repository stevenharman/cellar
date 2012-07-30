require 'brewery_db'

namespace :brewery_db do

  desc 'Import/update all BreweryDb.com data'
  task load: [:environment] do
    warehouse = Import::Warehouse.new(ENV['BREWERY_DB_API_KEY'])
    Impodrt::StockBoy.new(warehouse).inventory
  end

end
