require_relative 'beers_from_brewery_query'

module CleanUp

  def self.brewery(brewery)
    beers = BeersFromBreweryQuery.query(brewery)

    if beers.empty?
      brewery.destroy
    else
      fail "Brewery #{brewery.id} (#{brewery.brewery_db_id}) cannot be destroyed; it has #{beers.count} beers cellared."
    end
  end

  def self.brew(brew)
    if brew.beers.empty?
      brew.destroy
    else
      fail "Brew #{brew.id} (#{brew.brewery_db_id}) cannot be destroyed; it has #{brew.beers.count} beers cellared."
    end
  end

end
