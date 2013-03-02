class BreweryBrew < ActiveRecord::Base
  belongs_to :brewery, inverse_of: :brewery_brews
  belongs_to :brew, inverse_of: :brewery_brews

  validates :brewery, :brew, presence: true
  validates :brew_id, uniqueness: { scope: :brewery_id }
end
