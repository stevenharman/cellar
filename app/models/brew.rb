require 'pg_search'

class Brew < ActiveRecord::Base
  belongs_to :availability, inverse_of: :brews
  belongs_to :base_brew, inverse_of: :variations, class_name: 'Brew'
  belongs_to :style, inverse_of: :brews
  has_many :brewery_brews, inverse_of: :brew, dependent: :destroy
  has_many :breweries, -> { uniq }, through: :brewery_brews
  has_many :variations, inverse_of: :base_brew, class_name: 'Brew', foreign_key: 'base_brew_id'
  has_many :beers, inverse_of: :brew

  validates :name, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true }
  validates :brewery_db_id, uniqueness: true, presence: true

  #TODO use `coder: JSON` in Rails 4, consider hstore field
  LABELS = [:icon, :medium_image, :large_image].freeze
  store :labels, accessors: LABELS

  scope :cellared, -> { all.merge(Beer.cellared) }
  scope :by_name, -> { order(:name) }

  #TODO use tsvector columns w/triggers for updating.
  # see: https://github.com/jenseng/hair_trigger
  include PgSearch
  multisearchable against: [:searchable_name]

  LABELS.each do |label|
    define_method(label) do
      super() || 'no-label.png'
    end
  end

  def calculate_cellared_beers_count
    update_column(:cellared_beers_count, beers.cellared.count)
    cellared_beers_count
  end

  def searchable_name
    brewery_names = breweries.map { |b| b.name }.join(', ')
    "#{brewery_names} #{name}"
  end

end
