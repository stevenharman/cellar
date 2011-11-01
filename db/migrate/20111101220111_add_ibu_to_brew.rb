class AddIbuToBrew < ActiveRecord::Migration
  def change
    add_column :brews, :ibu, :integer
  end
end
