require_relative 'application_decorator'
require_relative '../models/brew'

class CellaredBrewDecorator < ApplicationDecorator
  decorates :brew

  def initialize(args)
    @cellar = args.delete(:cellar)
    super(args.delete(:brew), args)
  end

  def beers
    @beers ||= cellar.beers_for(brew)
  end

  def beer_count
    beers.size
  end

  private

  attr_reader :cellar
end
