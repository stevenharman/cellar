class Brewery < ActiveRecord::Base
  has_many :brews

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :name, :description, :established, :organic, :website
  store :images, accessors: [ :icon, :medium_image, :large_image ]

  include PgSearch
  multisearchable against: [:name]
end
