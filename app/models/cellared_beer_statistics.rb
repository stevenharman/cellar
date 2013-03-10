require 'delegate'
require_relative 'cellared_beer_statistics_query'

class CellaredBeerStatistics < SimpleDelegator

  def self.analyze(keeper)
    new(CellaredBeerStatisticsQuery.query(keeper))
  end

  def beers_count(brew = nil)
    return total_beer_count unless brew

    self.fetch(brew.id) { 0 }
  end

  def brews_count
    self.size
  end

  private

  def total_beer_count
    self.values.reduce(&:+)
  end

end
