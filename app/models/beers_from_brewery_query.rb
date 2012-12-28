require 'delegate'

class BeersFromBreweryQuery < SimpleDelegator

  def initialize(brewery, scope = Beer.scoped)
    brewery_db_id = brewery.brewery_db_id
    super(scope.joins(brew: :breweries).where(breweries: { brewery_db_id: brewery_db_id }))
  end

end

