require 'active_model'

class Profile
  extend Forwardable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :cellar, :user
  delegate [:beers_count, :brews_count, :total_breweries] => :cellar
  delegate [:bio, :gravatar, :joined, :location, :name, :username, :website] => :user
  delegate [:valid?, :errors] => :user

  def self.for(cellar)
    new(cellar)
  end

  def initialize(cellar)
    @cellar = cellar
    @user = cellar.keeper
  end

  # TODO: Ensure the user's #website is legit; URI.parse & check protocol & host.

  def update(profile_args)
    user.update(profile_args)
  end

  def bio?
    bio.present?
  end

  def location?
    location.present?
  end

  def website?
    website.present?
  end

  def persisted?
    false
  end

end
