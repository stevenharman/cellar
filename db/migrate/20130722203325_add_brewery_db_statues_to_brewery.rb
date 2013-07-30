class AddBreweryDbStatuesToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :brewery_db_status, :string, null: false, default: 'unknown'
    add_index :breweries, :brewery_db_status
  end
end
