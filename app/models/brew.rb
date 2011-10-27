class Brew < ActiveRecord::Base
  belongs_to :brewery
  has_many :beers

  validates :name, uniqueness: true, presence: true
  validates :brewery, presence: true

  attr_accessible :name, :abv, :description
end
