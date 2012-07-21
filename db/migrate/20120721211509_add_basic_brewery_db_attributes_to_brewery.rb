class AddBasicBreweryDbAttributesToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :description, :text
    add_column :breweries, :established, :date
    add_column :breweries, :organic, :boolean
    add_column :breweries, :images, :text
  end
end
