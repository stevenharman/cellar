class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name, null: false
      t.integer :brewery_db_id, null: false
      t.references :category, null: false

      t.timestamps
    end

    add_index :styles, :name, :unique => true
    add_index :styles, :category_id
    add_index :styles, :brewery_db_id, unique: true
  end
end
