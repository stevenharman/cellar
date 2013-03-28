class AddCellaredBeersCountToBrew < ActiveRecord::Migration
  def up
    add_column :brews, :cellared_beers_count, :integer, default: 0, null: false
    execute "UPDATE brews SET cellared_beers_count=(SELECT COUNT(*) FROM beers WHERE brew_id=brews.id AND status='cellared')"
  end

  def down
    remove_column :brews, :cellared_beers_count
  end
end
