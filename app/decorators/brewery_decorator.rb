class BreweryDecorator < ApplicationDecorator
  delegate_all
  decorates_association :brews, scope: :by_name

  def website_name
    strip_protocol(website)
  end

end
