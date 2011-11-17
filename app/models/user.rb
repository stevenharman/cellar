class User < ActiveRecord::Base
  has_many(:beers)

  authenticates_with_sorcery!
  attr_accessible :email, :username, :password

  validates :email, presence: true
  validates :username, uniqueness: true, presence: true
  validates :password, presence: { on: :create }
end
