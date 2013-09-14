module BreweryDbHelper
  def brewery_db_brew_url(brew)
    "http://www.brewerydb.com/beer/#{brew.brewery_db_id}"
  end

  def brewery_db_brewery_url(brewery)
    "http://www.brewerydb.com/brewery/#{brewery.brewery_db_id}"
  end
end
