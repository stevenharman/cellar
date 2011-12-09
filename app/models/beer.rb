class Beer < ActiveRecord::Base
  belongs_to :brew
  belongs_to :user

  validates :brew, presence: true
  validates :user, presence: true
  validates :status, inclusion: [:stocked, :drunk, :traded, :skunked]

  attr_accessible :batch, :bottled_on, :best_by

  scope :stocked, where(status: :stocked)
  scope :drunk, where(status: :drunk)
  scope :traded, where(status: :traded)
  scope :skunked, where(status: :skunked)

  def owned_by?(other_user)
    self.user == other_user
  end

  def status
    read_attribute(:status).to_sym
  end

  def status=(value)
    write_attribute(:status, value.to_s)
  end

  def self.make(attributes, brew)
    self.new(attributes) do |beer|
      beer.brew = brew
    end
  end
end
