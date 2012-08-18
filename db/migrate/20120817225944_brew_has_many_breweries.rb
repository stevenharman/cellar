class BrewHasManyBreweries < ActiveRecord::Migration
  def up
    create_table :brewery_brews do |t|
      t.integer :brewery_id, null: false
      t.integer :brew_id, null: false
      t.timestamps
    end
    add_index :brewery_brews, :brewery_id
    add_index :brewery_brews, :brew_id

    remove_column :brews, :brewery_id
  end

  def down
    drop_table :brewery_brews
    add_column :brew, :brewery_id, null: false
  end
end
