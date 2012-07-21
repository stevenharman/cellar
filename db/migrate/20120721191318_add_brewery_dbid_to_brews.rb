class AddBreweryDbidToBrews < ActiveRecord::Migration
  def change
    add_column :brews, :brewery_db_id, :string, null: false
    add_index :brews, :brewery_db_id, :unique => true
  end
end
