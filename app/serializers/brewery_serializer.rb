class BrewerySerializer < ApplicationSerializer
  attributes :id, :name

  links do
    link :self, href: brewery_url(object)
    link :mediumImage, href: object.medium_image if object.medium_image?
  end
end
