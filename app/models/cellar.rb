require_relative 'cellared_beer_statistics'
require_relative 'profile'
require_relative 'stock_order_receipt'

class Cellar
  attr_reader :keeper, :beer_stats

  def self.for(keepers)
    Array(keepers).map { |k| find_by(k) }
  end

  def self.find_by(keeper)
    new(keeper, CellaredBeerStatistics.analyze(keeper))
  end

  def initialize(keeper, cellared_beer_stats)
    @keeper = keeper
    @beer_stats = cellared_beer_stats
  end

  def profile
    @profile ||= Profile.new(self)
  end

  # TODO: remove this?
  def name
    keeper.username
  end

  def active?
    keeper.active?
  end

  def total_breweries
    keeper.breweries.cellared.count
  end

  def cellared_brews
    keeper.cellared_brews.by_name
  end

  def brews_count
    beer_stats.brews_count
  end

  def beers_count(brew = nil)
    beer_stats.beers_count(brew)
  end

  def beers_for(brew)
    keeper.cellared_beers(brew)
  end

  def find_beer(id)
    keeper.find_beer(id)
  end

  def kept_by?(other_user)
    keeper == other_user
  end

  def add(beer)
    keeper.beers.push(beer)
  end

  def update(beer_id, status)
    beer = find_beer(beer_id)
    beer.update_status(status)
    beer
  end

end
