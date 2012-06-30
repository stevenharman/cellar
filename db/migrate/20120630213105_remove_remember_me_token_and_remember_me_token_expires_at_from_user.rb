class RemoveRememberMeTokenAndRememberMeTokenExpiresAtFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :remember_me_token
    remove_column :users, :remember_me_token_expires_at
  end

  def down
    add_column :users, :remember_me_token_expires_at, :datetime
    add_column :users, :remember_me_token, :string
  end
end
