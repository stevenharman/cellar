require_relative 'application_decorator'
require_relative '../models/brew'

class CellaredBrewDecorator < ApplicationDecorator
  decorates :brew
  delegate_all

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

  def style_name
    style && style.name
  end

  private

  attr_reader :cellar
end
