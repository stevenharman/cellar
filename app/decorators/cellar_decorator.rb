class CellarDecorator < ApplicationDecorator
  delegate_all
  decorates_association :keeper, with: UserDecorator
  decorates_association :profile, with: ProfileDecorator

  alias_method :cellar, :source

  # TODO: Just put this in the view?
  def full_name
    h.t('cellar.full_name', name: cellar.name)
  end

  def location
    keeper.location unless keeper.location.blank?
  end

  def cellared_brews
    brews = cellar.cellared_brews.includes(:style).includes(:breweries).decorate
  end

end
