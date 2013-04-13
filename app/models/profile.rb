require 'active_model'

class Profile
  extend Forwardable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :cellar, :user
  delegate [:beers_count, :brews_count, :total_breweries] => :cellar
  delegate [:bio, :joined, :location, :gravatar, :username, :website] => :user
  delegate [:valid?, :errors] => :user

  def initialize(cellar)
    @cellar = cellar
    @user = cellar.keeper
  end

  # TODO: Ensure the user's #website is legit; URI.parse & check protocol & host.

  def update(profile_args)
    user.update_attributes(profile_args)
  end

  def persisted?
    false
  end

end
