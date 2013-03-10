require 'delegate'

class CellaredBeerStatisticsQuery < SimpleDelegator

  def self.query(keeper)
    new(keeper)
  end

  def initialize(keeper)
    super(keeper.cellared_beers.group(:brew_id).count)
  end

end
