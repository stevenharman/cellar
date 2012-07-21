class ChangeDefaultBeerStatusToCellared < ActiveRecord::Migration
  def change
    change_column_default(:beers, :status, :cellared)
  end
end
