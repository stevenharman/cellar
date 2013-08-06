class Size < ActiveRecord::Base
  has_many :beers, inverse_of: :size

  validates :measure, presence: true
  validates :quantity, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true
end
