require 'delegate'

class BeersFromBreweryQuery < SimpleDelegator

  def self.query(brewery)
    new(brewery)
  end

  def initialize(brewery, scope = Beer.all)
    brewery_db_id = brewery.brewery_db_id
    super(scope.joins(brew: :breweries).where(breweries: { brewery_db_id: brewery_db_id }))
  end

end

