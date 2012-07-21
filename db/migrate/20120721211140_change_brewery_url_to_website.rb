class ChangeBreweryUrlToWebsite < ActiveRecord::Migration
  def change
    rename_column :breweries, :url, :website
  end
end
