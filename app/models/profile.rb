class Profile
  extend Forwardable

  attr_reader :cellar, :user
  delegate [:beers_count, :brews_count, :total_breweries] => :cellar
  delegate [:bio, :joined, :location, :gravatar, :username, :website] => :user

  def initialize(cellar)
    @cellar = cellar
    @user = cellar.keeper
  end

  # TODO: Ensure the user's #website is legit; URI.parse & check protocol & host.

end
