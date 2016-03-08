class AddADatetimeBlahToTestHeroku < ActiveRecord::Migration
  def change
    add_column :users, :blah_at, :datetime
  end
end
