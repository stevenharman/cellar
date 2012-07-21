class Category < ActiveRecord::Base
  has_many :styles

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :name

end
