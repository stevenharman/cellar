require 'active_support/core_ext/module/delegation'
require_relative 'beer_order_receipt'

class Cellar
  attr_reader :keeper

  def initialize(user, brew_master=BrewMaster)
    @keeper = user
    @brew_master = brew_master
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
    keeper.breweries.merge(Beer.cellared).count
  end

  def stocked_brews
    keeper.stocked_brews
  end

  def unique_brews
    stocked_brews.size
  end

  def total_beers(brew = nil)
    beers_for(brew).count
  end

  def beers_for(brew)
    keeper.stocked_beers(brew)
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
