class CreateBrewAvailabilities < ActiveRecord::Migration
  def change
    create_table :brew_availabilities do |t|
      t.integer :brewery_db_id, null: false
      t.string :name, null: false
      t.string :description
    end
    add_index :brew_availabilities, :brewery_db_id, unique: true
    add_index :brew_availabilities, :name, unique: true
  end
end
