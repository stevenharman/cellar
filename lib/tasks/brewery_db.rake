require 'brewery_db'
require 'service_keys'

namespace :brewery_db do

  desc 'Import/update all BreweryDb.com data'
  task import: [:environment] do
    require_relative '../../app/models/supply_chain/agent'

    warehouse = SupplyChain::Warehouse.new(ServiceKeys.brewery_db)
    SupplyChain::Agent.import_from(warehouse)
  end

end
