class RenameUserAdminToStaff < ActiveRecord::Migration
  def up
    remove_index :users, :admin
    rename_column :users, :admin, :staff
    add_index :users, :staff
  end

  def down
    remove_index :users, :staff
    rename_column :users, :staff, :admin
    add_index :users, :admin
  end
end
