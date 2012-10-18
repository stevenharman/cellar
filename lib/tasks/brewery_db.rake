require 'service_keys'
require 'brewery_db'

namespace :brewery_db do

  desc 'Import/update all BreweryDb.com data'
  task import: [:environment] do
    warehouse = Import::Warehouse.new(ServiceKeys.brewery_db)
    Import::Agent.import_from(warehouse)
  end

end
