class User < ActiveRecord::Base
  has_many :beers
  has_many :brews, through: :beers

  authenticates_with_sorcery!
  attr_accessible :email, :username, :password

  validates :email, presence: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: { on: :create }

  def self.for_username!(username)
    find_by_username!(username.downcase)
  end

  def find_beer(id)
    beers.find(id)
  end

  def to_param
    username
  end

  def stocked_brews
    brews.with_beers.merge(Beer.stocked)
  end

  def stocked_beers(brew)
    beers.stocked.by_brew(brew)
  end

end
