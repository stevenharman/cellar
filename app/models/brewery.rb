require 'pg_search'

class Brewery < ActiveRecord::Base
  has_many :brewery_brews, inverse_of: :brewery, dependent: :destroy
  has_many :brews, through: :brewery_brews, uniq: true

  validates :name, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :description, :established, :name, :organic, :website
  store :images, accessors: [:icon, :medium_image, :large_image]

  include PgSearch
  multisearchable against: [:name]

  scope :cellared, -> { scoped.merge(Beer.cellared) }

  def self.find_by_brewery_db_ids(ids)
    where(brewery_db_id: ids)
  end
end
