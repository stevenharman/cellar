class BreweryBrew < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :brew

  validates :brewery_id, presence: true
  validates :brew_id, presence: true, uniqueness: { scope: :brewery_id }
end
