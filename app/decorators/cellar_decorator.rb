class CellarDecorator < ApplicationDecorator
  delegate_all
  decorates_association :keeper, with: UserDecorator

  alias_method :cellar, :source

  def keeper_gravatar(*args)
    keeper.gravatar(*args)
  end

  def keeper_bio
    keeper.bio
  end

  def full_name
    h.t('cellar.full_name', name: cellar.name)
  end

  def location
    keeper.location unless keeper.location.blank?
  end

  def cellared_brews
    brews = cellar.cellared_brews.includes(:style).includes(:breweries).decorate
  end

  def website
    h.link_to(keeper.website, keeper.website) unless keeper.website.blank?
  end
end
