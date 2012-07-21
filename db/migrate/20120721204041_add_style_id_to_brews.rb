class AddStyleIdToBrews < ActiveRecord::Migration
  def change
    add_column :brews, :style_id, :integer
    add_index :brews, :style_id
  end
end
