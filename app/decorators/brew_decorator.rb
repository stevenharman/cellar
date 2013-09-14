class BrewDecorator < ApplicationDecorator
  delegate_all
  decorates_association :breweries

  def availability_name
    availability && availability.name
  end

  def style_name
    style && style.name
  end
end
