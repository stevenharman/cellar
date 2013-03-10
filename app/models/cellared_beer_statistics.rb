require_relative 'cellared_beer_statistics_query'

class CellaredBeerStatistics < DelegateClass(Hash)

  def self.analyze(keeper)
    new(CellaredBeerStatisticsQuery.query(keeper))
  end

end
