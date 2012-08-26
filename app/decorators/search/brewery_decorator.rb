module Search
  class BreweryDecorator < ApplicationDecorator
    decorates :brewery

    def to_partial_path() 'searches/brewery' end
  end
end
