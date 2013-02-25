class AddStatusAndUserIdIndexesToBeers < ActiveRecord::Migration
  def change
    add_index :beers, :status
    add_index :beers, :user_id
  end
end
