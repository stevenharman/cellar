class AddAdminFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_index :users, :admin
  end
end
