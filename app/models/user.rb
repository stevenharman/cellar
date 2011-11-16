class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email, :username

  validates :email, :presence => true
  validates :username, :uniqueness => true, :presence => true
end
