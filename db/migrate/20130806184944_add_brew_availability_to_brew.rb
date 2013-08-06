class AddBrewAvailabilityToBrew < ActiveRecord::Migration
  def change
    add_reference :brews, :brew_availability, index: true
  end
end
