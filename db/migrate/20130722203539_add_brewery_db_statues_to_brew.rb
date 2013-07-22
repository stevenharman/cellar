class AddBreweryDbStatuesToBrew < ActiveRecord::Migration
  def change
    add_column :brews, :brewery_db_status, :string, null: false, default: 'unknown'
    add_index :brews, :brewery_db_status
  end
end
