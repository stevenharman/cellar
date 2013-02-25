class CellarDecorator < ApplicationDecorator
  delegate_all
  decorates_association :keeper, with: UserDecorator

  alias_method :cellar, :source

  def keeper_gravatar(*args)
    keeper.gravatar(*args)
  end

  def name
    h.t('cellar.name', keeper: keeper_username)
  end

  def keeper_username
    keeper.username
  end

  def keeper_bio
    keeper.bio
  end

  def established
    keeper.joined
  end

  def location
    keeper.location unless keeper.location.blank?
  end

  def total_beers
    keeper.stocked_beers.count
  end

  def total_breweries
    keeper.breweries.merge(Beer.cellared).count
  end

  def unique_brews
    cellar.stocked_brews.size
  end

  def stocked_brews
    cellar.stocked_brews.includes(:breweries).map { |b| CellaredBrewDecorator.new(b, context: {cellar: cellar}) }
  end

  def website
    h.link_to(keeper.website, keeper.website) unless keeper.website.blank?
  end
end
