require 'pg_search'

class Brew < ActiveRecord::Base
  belongs_to :style, inverse_of: :brews
  belongs_to :base_brew, inverse_of: :variations, class_name: 'Brew'
  has_many :brewery_brews, inverse_of: :brew, dependent: :destroy
  has_many :breweries, through: :brewery_brews, uniq: true
  has_many :variations, inverse_of: :base_brew, class_name: 'Brew', foreign_key: 'base_brew_id'
  has_many :beers, inverse_of: :brew

  validates :name, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true }
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :abv, :base_brew_id, :description, :ibu, :name, :organic, :year
  store :labels, accessors: [:icon, :medium_image, :large_image]

  scope :cellared, -> { scoped.merge(Beer.cellared) }

  include PgSearch
  multisearchable against: [:searchable_name]

  def searchable_name
    brewery_names = breweries.map { |b| b.name }.join(', ')
    "#{brewery_names} #{name}"
  end

end
