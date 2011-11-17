class Beer < ActiveRecord::Base
  belongs_to :brew
  belongs_to :user

  validates :brew, presence: true
  validates :user, presence: true

  attr_accessible :batch, :bottled_on, :best_by
end
