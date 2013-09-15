require 'pg_search'

class Brewery < ActiveRecord::Base
  has_many :brewery_brews, inverse_of: :brewery, dependent: :destroy
  has_many :brews, -> { uniq }, through: :brewery_brews
  has_many :beers, through: :brews

  validates :name, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  #TODO use `coder: JSON` in Rails 4, consider hstore field
  IMAGES = [:icon, :medium_image, :large_image].freeze
  store :images, accessors: IMAGES

  #TODO use tsvector columns w/triggers for updating.
  # see: https://github.com/jenseng/hair_trigger
  include PgSearch
  multisearchable against: [:name]

  scope :cellared, -> { all.merge(Beer.cellared) }
  scope :neglected, -> { where(brewery_db_status: [:deleted, :unknown]) }

  def self.find_by_brewery_db_ids(ids)
    where(brewery_db_id: ids)
  end

  IMAGES.each do |image|
    define_method(image) do
      super() || 'no-brewery.png'
    end
  end
end
