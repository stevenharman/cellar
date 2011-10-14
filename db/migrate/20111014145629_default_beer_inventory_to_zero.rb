class DefaultBeerInventoryToZero < ActiveRecord::Migration
  def change
    change_column :beers, :inventory, :integer, default: 0, null: false
  end
end
