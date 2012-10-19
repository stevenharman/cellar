require 'service_keys'
require 'brewery_db'

namespace :brewery_db do

  desc 'Import/update all BreweryDb.com data'
  task import: [:environment] do
    warehouse = SupplyChain::Warehouse.new(ServiceKeys.brewery_db)
    SupplyChain::Agent.import_from(warehouse)
  end

end
