class Brew < ActiveRecord::Base
  belongs_to :brewery

  validates :name, uniqueness: true, presence: true
  validates :brewery, presence: true

  attr_accessible :name, :abv
end
