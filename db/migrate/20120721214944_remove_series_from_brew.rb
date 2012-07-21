class RemoveSeriesFromBrew < ActiveRecord::Migration
  def up
    remove_column :brews, :series
  end

  def down
    add_column :brews, :series, :string
  end
end
