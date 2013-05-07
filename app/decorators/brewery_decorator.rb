class BreweryDecorator < ApplicationDecorator
  delegate_all
  decorates_association :brews

  def website_name
    strip_protocol(website)
  end

end
