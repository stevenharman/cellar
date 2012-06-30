class RemoveCryptedPasswordAndSaltFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :crypted_password
    remove_column :users, :salt
  end

  def down
    add_column :users, :salt, :string
    add_column :users, :crypted_password, :string
  end
end
