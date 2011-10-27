class RenameBornOnToBottledOnOnBeers < ActiveRecord::Migration
  def change
    rename_column :beers, :born_on, :bottled_on
  end
end
