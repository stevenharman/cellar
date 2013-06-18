require_relative 'cellared_beer_statistics_query'

class CellaredBeerStatistics

  def self.analyze(keeper)
    new(CellaredBeerStatisticsQuery.query(keeper))
  end

  def initialize(raw_stats)
    @stats = raw_stats
  end

  def beers_count(brew = nil)
    return total_beer_count unless brew

    stats.fetch(brew.id) { 0 }
  end

  def brews_count
    stats.size
  end

  def to_hash
    stats.to_hash
  end

  private

  def total_beer_count
    stats.values.reduce(0, :+)
  end

  def stats
    @stats
  end

end
