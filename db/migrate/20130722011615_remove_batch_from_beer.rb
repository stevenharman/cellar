class RemoveBatchFromBeer < ActiveRecord::Migration
  def up
    remove_column :beers, :batch
  end

  def down
    add_column :beers, :batch, :string
  end
end
