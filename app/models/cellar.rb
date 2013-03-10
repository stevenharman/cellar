require 'active_support/core_ext/module/delegation'
require_relative 'beer_order_receipt'

class Cellar
  attr_reader :keeper

  def initialize(user)
    @keeper = user
  end

  def name
    keeper.username
  end

  def active?
    keeper.active?
  end

  def established
    keeper.joined
  end

  def total_breweries
    keeper.breweries.cellared.count
  end

  def cellared_brews
    keeper.cellared_brews
  end

  def unique_brews
    cellared_brews.size
  end

  def total_beers(brew = nil)
    beers_for(brew).count
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

end
