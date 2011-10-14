class CreateBrews < ActiveRecord::Migration
  def change
    create_table :brews do |t|
      t.string :name
      t.string :series
      t.decimal :abv, precision: 5, scale: 2
      t.references :brewery

      t.timestamps
    end
    add_index :brews, :brewery_id
    add_index :brews, :name, unique: true
  end
end
