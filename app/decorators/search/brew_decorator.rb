module Search
  class BrewDecorator < ApplicationDecorator
    decorates :brew

    def to_partial_path() 'searches/brew' end
  end
end
