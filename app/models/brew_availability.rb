class BrewAvailability < ActiveRecord::Base
  has_many :brews, inverse_of: :availability

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true
end
