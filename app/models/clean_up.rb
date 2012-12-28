require_relative 'beers_from_brewery_query'

module CleanUp

  def self.brewery(brewery_db_id, brewery_factory = Brewery)
    # TODO: take in a Brewery instance to be cleaned up.
    brewery = brewery_factory.find_by_brewery_db_id(brewery_db_id)
    beers = BeersFromBreweryQuery.new(brewery)

    if(beers.empty?)
      brewery.destroy
    else
      fail "Brewery #{brewery.id} (#{brewery.brewery_db_id}) cannot be destroyed; it has #{beers.count} beers cellared."
    end
  end

end
