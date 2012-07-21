class Brewery < ActiveRecord::Base
  has_many :brews

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :name, :website

  include PgSearch
  multisearchable against: [:name]
end
