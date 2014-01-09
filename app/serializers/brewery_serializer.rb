class BrewerySerializer < ApplicationSerializer
  attributes :id, :name

  links do
    link :self, href: urls.brewery_url(object)
    link :mediumImage, href: object.medium_image
  end
end
