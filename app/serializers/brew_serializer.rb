class BrewSerializer < ApplicationSerializer
  attributes :id, :name

  has_many :breweries

  links do
    link :self, href: urls.brew_url(object)
    # TODO: Move this to a :labels object
    link :mediumLabel, href: object.medium_image if object.medium_image?
  end

end
