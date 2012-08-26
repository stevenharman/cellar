class BeerOrder
  attr_reader :count
  attr_reader :brew_id
  attr_reader :beers

  def initialize(count, beer_stuffs)
    @count = [0, count].max
    @brew_id = beer_stuffs.delete(:brew_id)
    @beers = Array.new(@count, beer_stuffs)
  end
end
