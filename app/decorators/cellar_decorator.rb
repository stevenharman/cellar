class CellarDecorator < ApplicationDecorator
  decorates_association :keeper

  def keeper_gravatar(*args)
    keeper.gravatar(*args)
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

  end

  def unique_brews
    stocked_brews.size
  end

  def website
    h.link_to('http://example.com', 'http://example.com')
  end
end
