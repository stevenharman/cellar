module Search
  class BrewDecorator < ApplicationDecorator
    decorates :brew
    delegate_all

    def to_partial_path() 'searches/brew' end
  end
end
