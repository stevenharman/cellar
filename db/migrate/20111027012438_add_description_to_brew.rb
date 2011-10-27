class AddDescriptionToBrew < ActiveRecord::Migration
  def change
    add_column :brews, :description, :text
  end
end
