class Brewery < ActiveRecord::Base
  has_many :brews

  validates :name, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :description, :established, :name, :organic, :website
  store :images, accessors: [:icon, :medium_image, :large_image]

  include PgSearch
  multisearchable against: [:name]
end
