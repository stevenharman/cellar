class CellarDecorator < ApplicationDecorator
  delegate_all
  decorates_association :keeper

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
    # TODO: drop the #to_a when this is fixed https://github.com/rails/rails/issues/1003
    keeper.breweries.merge(Beer.cellared).to_a.count
  end

  def unique_brews
    # TODO: drop the #to_a when this is fixed https://github.com/rails/rails/issues/1003
    stocked_brews.to_a.size
  end

  def stocked_brews
    cellar.stocked_brews.with_breweries
  end

  def website
    h.link_to(keeper.website, keeper.website) unless keeper.website.blank?
  end
end
