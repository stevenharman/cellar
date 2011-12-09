class Brew < ActiveRecord::Base
  belongs_to :brewery
  has_many :beers

  validates :name, uniqueness: true, presence: true
  validates :brewery, presence: true
  validates :abv, numericality: { allow_nil: true }
  validates :ibu, numericality: { allow_nil: true, only_integer: true }

  attr_accessible :name, :abv, :description, :ibu

  default_scope includes(:brewery)
  scope :with_beers, includes(:beers).joins(:beers)

  def self.from_cellar(keeper)
    with_beers.where('beers.status' => :stocked).where('beers.user_id' => keeper)
  end

end
