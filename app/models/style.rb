class Style < ActiveRecord::Base
  belongs_to :category, inverse_of: :styles
  has_many :brews, inverse_of: :style

  validates :category, presence: true
  validates :name, uniqueness: true, presence: true
  validates :brewery_db_id, uniqueness: true, presence: true

end
