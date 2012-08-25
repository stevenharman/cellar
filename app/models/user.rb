class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :validatable, :lockable, :timeoutable and
  # :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable#, :confirmable

  attr_accessible :email, :username, :password, :remember_me
  has_many :beers
  has_many :brews, through: :beers

  validates :email, uniqueness: true, presence: true, email: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: { on: :create },
                       length: { in: 6...128, if: 'password.present?' }

  def self.for_username!(username)
    find_by_username!(username.downcase)
  end

  def find_beer(id)
    beers.find(id)
  end

  def stocked_brews
    brews.with_beers.merge(Beer.cellared)
  end

  def stocked_beers(brew)
    beers.cellared.by_brew(brew)
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
end
