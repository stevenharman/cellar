class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.integer :brewery_db_id
      t.string :measure, null: false
      t.string :quantity, null: false
      t.string :name
    end
    add_index :sizes, :brewery_db_id
  end
end
