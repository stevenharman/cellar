require 'brewery_db'

namespace :brewery_db do

  desc 'Import/update all BreweryDb.com data'
  task import: [:environment] do
    warehouse = Import::Warehouse.new(ENV['BREWERY_DB_API_KEY'])
    Import::Agent.import_from(warehouse)
  end

end
