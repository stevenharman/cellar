class RenameBrewAvailabilityToAvailability < ActiveRecord::Migration
  def change
    rename_table :brew_availabilities, :availabilities
    rename_column :brews, :brew_availability_id, :availability_id
  end
end
