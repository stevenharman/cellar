class RemoveDescriptionAndInventoryFromBeer < ActiveRecord::Migration
  def up
    remove_column :beers, :description
    remove_column :beers, :inventory
  end

  def down
    add_column :beers, :inventory, :integer
    add_column :beers, :description, :text
  end
end
