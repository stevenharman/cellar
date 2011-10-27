class Beer < ActiveRecord::Base
  belongs_to :brew

  validates :brew, presence: true

  attr_accessible :batch, :born_on, :best_by
end
