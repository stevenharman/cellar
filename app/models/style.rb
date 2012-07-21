class Style < ActiveRecord::Base
  belongs_to :category
  has_many :brews

  validates :category, presence: true
  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :name

end
