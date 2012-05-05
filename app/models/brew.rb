class Brew < ActiveRecord::Base
  belongs_to :brewery
  has_many :beers

  validates :name, uniqueness: { scope: :brewery_id }, presence: true
  validates :brewery, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true, only_integer: true }

  attr_accessible :abv, :description, :ibu, :name, :series

  include PgSearch
  multisearchable against: [:searchable_name]

  scope :with_beers, includes(:beers).joins(:beers)

  def searchable_name
    "#{brewery.name} #{name}"
  end

end
