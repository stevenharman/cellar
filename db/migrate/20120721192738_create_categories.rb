class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :brewery_db_id, null: false

      t.timestamps
    end

    add_index :categories, :name, unique: true
    add_index :categories, :brewery_db_id, unique: true
  end
end
