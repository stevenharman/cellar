class Category < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

  attr_accessible :name

end
