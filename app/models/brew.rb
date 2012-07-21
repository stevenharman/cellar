class Brew < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style
  has_many :beers

  validates :brewery, presence: true
  validates :name, uniqueness: { scope: :brewery_id }, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true, only_integer: true }
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :abv, :description, :ibu, :name

  include PgSearch
  multisearchable against: [:searchable_name]

  scope :with_beers, includes(:beers).joins(:beers)

  def searchable_name
    "#{brewery.name} #{name}"
  end

end
