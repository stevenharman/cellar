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

  def established
    "#{h.distance_of_time_in_words_to_now(keeper.joined)} ago"
  end

  def location
    'Fix this, USA'
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
    h.link_to('http://example.com', 'http://example.com')
  end
end
