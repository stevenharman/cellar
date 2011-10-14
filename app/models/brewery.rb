class Brewery < ActiveRecord::Base

  has_many :brews
  validates :name, uniqueness: true, presence: true

  attr_accessible :name, :url
end
