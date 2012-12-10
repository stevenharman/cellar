class AddCompositIndexOnBreweryBrewsBreweryIdBrewId < ActiveRecord::Migration
  def up
    remove_index :brewery_brews, column: :brewery_id
    add_index :brewery_brews, [:brewery_id, :brew_id], unique: true, name: 'index_brewery_brews_on_brewery_id_brew_id'
  end

  def down
    remove_index :brewery_brews, name: 'index_brewery_brews_on_brewery_id_brew_id'
    add_index :brewery_brews, [:brewery_id]
  end
end
