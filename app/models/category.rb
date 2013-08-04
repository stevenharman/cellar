class Category < ActiveRecord::Base
  has_many :styles, inverse_of: :category, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

end
