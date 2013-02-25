require_relative 'brew_decorator'

class CellaredBrewDecorator < BrewDecorator
  decorates :brew

  def initialize(args)
    @cellar = args.delete(:cellar)
    super(args.delete(:brew), args)
  end

  def beers
    @beers ||= cellar.beers_for(model)
  end

  def beer_count
    beers.size
  end

  private

  attr_reader :cellar
end
