class Beer < ActiveRecord::Base
  belongs_to :brew
  belongs_to :user

  validates :brew, presence: true
  validates :user, presence: true

  attr_accessible :batch, :bottled_on, :best_by

  def owned_by?(other_user)
    self.user == other_user
  end

  def self.make(attributes, brew)
    self.new(attributes) do |beer|
      beer.brew = brew
    end
  end
end
