class Brewery < ActiveRecord::Base
  has_many :brewery_brews, dependent: :destroy
  has_many :brews, through: :brewery_brews, uniq: true

  validates :name, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :description, :established, :name, :organic, :website
  store :images, accessors: [:icon, :medium_image, :large_image]

  include PgSearch
  multisearchable against: [:name]
end
