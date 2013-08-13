module SupplyChain
  class WarehouseMap

    def find_availability(brewery_db_id)
      ::Availability.find_by_brewery_db_id(brewery_db_id)
    end

    def find_category(brewery_db_id)
      ::Category.find_by_brewery_db_id(brewery_db_id)
    end

    def find_style(brewery_db_id)
      ::Style.find_by_brewery_db_id(brewery_db_id)
    end

    def find_breweries(brewery_db_ids)
      ::Brewery.find_by_brewery_db_ids(brewery_db_ids)
    end

  end
end
