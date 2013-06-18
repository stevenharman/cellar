require 'devise'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :validatable, :lockable, :timeoutable and
  # :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :confirmable

  attr_accessible :bio, :email, :location, :name, :password, :remember_me,
                  :username, :website

  has_many :beers, inverse_of: :user
  has_many :brews, through: :beers, uniq: true
  has_many :breweries, through: :brews, uniq: true

  validates :email, uniqueness: true, presence: true, email: true
  validates :username, uniqueness: true, presence: true
  validates :website, url: true, allow_blank: true
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

  def cellared_brews
    brews.cellared
  end

  def cellared_beers(brew = nil)
    cellared = beers.cellared
    cellared = cellared.by_brew(brew) if brew
    cellared
  end

  def joined
    created_at
  end

  def update_password(new_password)
    self.password = new_password
    result = self.save
    self.password = self.password_confirmation = nil
    result
  end

  def website=(value)
    value = Website.parse(value) unless value.blank?
    write_attribute(:website, value)
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
