class Brew < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style
  belongs_to :base_brew, class_name: 'Brew'
  has_many :variations, class_name: 'Brew', foreign_key: 'base_brew_id'
  has_many :beers

  validates :brewery, presence: true
  validates :name, uniqueness: { scope: :brewery_id }, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true, only_integer: true }
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :abv, :base_brew_id, :description, :ibu, :name, :organic, :year
  store :labels, accessors: [:icon, :medium_image, :large_image]

  include PgSearch
  multisearchable against: [:searchable_name]

  scope :with_beers, includes(:beers).joins(:beers)

  def searchable_name
    "#{brewery.name} #{name}"
  end

end
