class AddBreweryDbAttributesToBrew < ActiveRecord::Migration
  def change
    add_column :brews, :labels, :text
    add_column :brews, :year, :date
    add_column :brews, :organic, :boolean
    add_column :brews, :base_brew_id, :string
    add_column :brews, :original_gravity, :decimal
  end
end
