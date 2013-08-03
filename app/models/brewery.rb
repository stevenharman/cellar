require 'pg_search'

class Brewery < ActiveRecord::Base
  has_many :brewery_brews, inverse_of: :brewery, dependent: :destroy
  has_many :brews, -> { uniq }, through: :brewery_brews

  validates :name, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :description, :established, :name, :organic, :website
  #TODO use `coder: JSON` in Rails 4, consider hstore field
  store :images, accessors: [:icon, :medium_image, :large_image]

  #TODO use tsvector columns w/triggers for updating.
  # see: https://github.com/jenseng/hair_trigger
  include PgSearch
  multisearchable against: [:name]

  scope :cellared, -> { all.merge(Beer.cellared) }

  def self.find_by_brewery_db_ids(ids)
    where(brewery_db_id: ids)
  end
end
