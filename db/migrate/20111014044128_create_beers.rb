class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :batch
      t.date :born_on
      t.date :best_by
      t.integer :inventory
      t.text :description
      t.references :brew

      t.timestamps
    end
    add_index :beers, :brew_id
  end
end
