class AddDescriptionToStyle < ActiveRecord::Migration
  def change
    add_column :styles, :description, :text
  end
end
