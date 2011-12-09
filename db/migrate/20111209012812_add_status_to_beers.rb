class AddStatusToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :status, :string, default: :stocked
  end
end
