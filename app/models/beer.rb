class Beer < ActiveRecord::Base
  belongs_to :brew, inverse_of: :beers
  belongs_to :user, inverse_of: :beers

  ALLOWED_STATUSES = [:cellared, :drunk, :traded, :skunked].freeze

  validates :brew, presence: true
  validates :user, presence: true
  validates :status, inclusion: ALLOWED_STATUSES

  #TODO: remove :status from attr_accessible
  attr_accessible :batch, :bottled_on, :best_by, :status

  scope :cellared, where(status: :cellared)
  scope :drunk, where(status: :drunk)
  scope :traded, where(status: :traded)
  scope :skunked, where(status: :skunked)

  def cellared_by?(other_user)
    self.user == other_user
  end

  ALLOWED_STATUSES.each do |s|
    define_method("#{s}?") do
      self.status == s
    end
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

  def self.by_brew(brew)
    where('beers.brew_id = ?', brew)
  end

  def self.cellared_by(keeper)
    where('beers.user_id = ?', keeper)
  end

end
