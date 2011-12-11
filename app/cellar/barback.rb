class Barback

  def initialize(fetch_brews=Brew)
    @fetch_brews = fetch_brews
  end

  def brews_from_cellar(keeper)
    fetch_brews.from_cellar(keeper)
  end

  private

  attr_reader :fetch_brews
end
