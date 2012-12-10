module SupplyChain
  class BrewCatalogOrder
    attr_reader :attribute_id

    def initialize(brewery_id)
      @attribute_id = brewery_id
    end

    def fetch_brew_catalog?
      true
    end

  end
end
