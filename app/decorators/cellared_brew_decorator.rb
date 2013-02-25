require_relative 'brew_decorator'

class CellaredBrewDecorator < BrewDecorator
  decorates :brew

  def initialize(*args)
    super
    @cellar = context.fetch(:cellar)
  end

  def beers
    @beers ||= cellar.beers_for(model)
  end

  def beer_count
    beers.size
  end

  def total_cellared
    # use a counter cache, #total_cellared
    model.beers.cellared.count
  end

  private

  attr_reader :cellar
end
