class ChangeBrewIbuToDecimal < ActiveRecord::Migration
  def change
    change_column :brews, :ibu, :decimal, precision: 5, scale: 2
  end
end
