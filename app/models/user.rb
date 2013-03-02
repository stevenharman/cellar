class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :validatable, :lockable, :timeoutable and
  # :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :confirmable

  attr_accessible :bio, :email, :location, :password, :remember_me, :username, :website
  has_many :beers
  has_many :brews, through: :beers, uniq: true
  has_many :breweries, through: :brews, uniq: true

  validates :email, uniqueness: true, presence: true, email: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: { if: :password_required? },
                       length: { in: 8...128, if: 'password.present?' }

  def self.for_username!(username)
    find_by_username!(username.downcase)
  end

  def active?
    persisted?
  end

  def find_beer(id)
    beers.find(id)
  end

  def stocked_brews
    brews.merge(Beer.cellared)
  end

  def stocked_beers(brew = nil)
    cellared_beers = beers.cellared
    cellared_beers = cellared_beers.by_brew(brew) if brew
    cellared_beers
  end

  def joined
    created_at
  end

  # Public: Delegate to other's #model if it is a Draper decorator
  #
  # other - A User or UserDecorator
  def ==(other)
    super(other.respond_to?(:model) ? other.model : other)
  end

  def to_param
    username
  end

  private

  def password_required?
    new_record? || !password.nil?
  end
end
