module SupplyChain
  class WarehouseMap

    def find_availability(brewery_db_id)
      find(::Availability, brewery_db_id)
    end

    def find_category(brewery_db_id)
      find(::Category, brewery_db_id)
    end

    def find_style(brewery_db_id)
      find(::Style, brewery_db_id)
    end

    def find_brew(brewery_db_id)
      find(::Brew, brewery_db_id)
    end

    def find_breweries(brewery_db_ids)
      ::Brewery.find_by_brewery_db_ids(brewery_db_ids)
    end

    private

    def find(factory, id)
      factory.find_by_brewery_db_id(id) if id
    end

  end
end
