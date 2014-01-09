class BrewSerializer < ApplicationSerializer
  attributes :id, :name

  has_many :breweries

  links do
    link :self, href: urls.brew_url(object)
    link :mediumLabel, href: object.medium_image
  end

end
