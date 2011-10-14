class Beer < ActiveRecord::Base
  belongs_to :brew

  validates :brew, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
