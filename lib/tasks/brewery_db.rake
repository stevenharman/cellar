require 'brewery_db'

namespace :brewery_db do

  task load: [:environment] do
    warehouse = Warehouse.new(ENV['BREWERY_DB_API_KEY'])
    StockBoy.new(warehouse).inventory
  end

end
