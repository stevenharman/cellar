module Import
  class UnmatchedBrewSerializer < ApplicationSerializer
    attributes :name, :breweries

    def filter(keys)
      keys = super(keys)
      keys.delete(:id)
      keys
    end

    def breweries
      [{ name: object.brewery }]
    end

  end
end
