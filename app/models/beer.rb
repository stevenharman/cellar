class Beer < ActiveRecord::Base
  belongs_to :brew, inverse_of: :beers
  belongs_to :size, inverse_of: :beers
  belongs_to :user, inverse_of: :beers

  ALLOWED_STATUSES = %w(cellared drunk traded skunked).freeze

  validates :brew, presence: true
  validates :user, presence: true
  validates :status, inclusion: ALLOWED_STATUSES
  validates :vintage, numericality: { allow_nil: true, only_integer: true }

  scope :cellared, -> { where(status: :cellared) }
  scope :drunk, -> { where(status: :drunk) }
  scope :traded, -> { where(status: :traded) }
  scope :skunked, -> { where(status: :skunked) }

  def cellared_by?(other_user)
    self.user == other_user
  end

  ALLOWED_STATUSES.each do |s|
    define_method("#{s}?") do
      self.status == s
    end
  end

  def update_status(value)
    self.status = value
    save
  end

  def self.make(attributes, brew)
    self.new(attributes) do |beer|
      beer.brew = brew
    end
  end

  def self.by_brew(brew)
    where(brew_id: brew)
  end

  def self.cellared_by(keeper)
    where(user_id: keeper)
  end

end
