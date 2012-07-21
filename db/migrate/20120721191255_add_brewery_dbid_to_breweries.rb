class AddBreweryDbidToBreweries < ActiveRecord::Migration
  def change
    add_column :breweries, :brewery_db_id, :string, null: false
    add_index :breweries, :brewery_db_id, :unique => true
  end
end
