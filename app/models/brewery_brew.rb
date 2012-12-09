class BreweryBrew < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :brew

  validates :brewery, :brew, presence: true
  validates :brew_id, uniqueness: { scope: :brewery_id }
end
