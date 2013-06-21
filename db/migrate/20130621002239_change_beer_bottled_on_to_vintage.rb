class ChangeBeerBottledOnToVintage < ActiveRecord::Migration
  def change
    add_column :beers, :vintage, :integer
    remove_column :beers, :bottled_on
  end
end
