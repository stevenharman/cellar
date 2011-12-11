class Barback

  def initialize(fetch_brews=Brew, fetch_beers=Beer)
    @fetch_brews = fetch_brews
    @fetch_beers = fetch_beers
  end

  def brews_from_cellar(keeper)
    fetch_brews.from_cellar(keeper)
  end

  def beers_from_cellar_for_brew(keeper, brew)
    fetch_beers.from_cellar(keeper, brew: brew)
  end

  private

  attr_reader :fetch_brews, :fetch_beers
end
