class User < ActiveRecord::Base
  has_many(:beers)

  authenticates_with_sorcery!
  attr_accessible :email, :username, :password

  validates :email, presence: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: { on: :create }

  def to_param
    username
  end

  def self.for_username!(username)
    find_by_username!(username.downcase)
  end

end
