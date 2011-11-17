class AddUserIdToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :user_id, :integer
  end
end
