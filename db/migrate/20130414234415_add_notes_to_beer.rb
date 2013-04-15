class AddNotesToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :notes, :text
  end
end
