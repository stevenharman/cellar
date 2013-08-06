require 'brewery_db'
require 'service_keys'

namespace :brewery_db do
  require_relative '../../app/models/supply_chain/agent'

  desc 'Import/update all BreweryDb.com data'
  task import: [:environment] do
    warehouse = SupplyChain::Warehouse.new(ServiceKeys.brewery_db)
    SupplyChain::Agent.import_from(warehouse)
  end

  namespace :import do

    desc 'Import/update BreweryDb.com reference data (Style, Category, Availability)'
    task reference_data: [:environment] do
      warehouse = SupplyChain::Warehouse.new(ServiceKeys.brewery_db)
      SupplyChain::Agent.new(warehouse).import_reference_data
    end
  end

end
