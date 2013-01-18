module Search
  class BreweryDecorator < ApplicationDecorator
    decorates :brewery
    delegate_all

    def to_partial_path() 'searches/brewery' end
  end
end
