require 'pg_search'

class Brew < ActiveRecord::Base
  belongs_to :style
  belongs_to :base_brew, class_name: 'Brew'
  has_many :brewery_brews, inverse_of: :brew, dependent: :destroy
  has_many :breweries, through: :brewery_brews, uniq: true
  has_many :variations, class_name: 'Brew', foreign_key: 'base_brew_id'
  has_many :beers

  #validates :breweries, presence: true
  validates :name, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true }
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :abv, :base_brew_id, :description, :ibu, :name, :organic, :year
  store :labels, accessors: [:icon, :medium_image, :large_image]

  include PgSearch
  multisearchable against: [:searchable_name]

  def searchable_name
    brewery_names = breweries.map { |b| b.name }.join(', ')
    "#{brewery_names} #{name}"
  end

end
