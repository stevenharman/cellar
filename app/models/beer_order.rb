class BeerOrder
  attr_reader :count
  attr_reader :brew_id
  attr_reader :beers

  def initialize(beer_stuffs)
    requested_count = (beer_stuffs.delete(:count) || 0).to_i
    @count = [0, requested_count].max
    @brew_id = beer_stuffs.delete(:brew_id)
    @beers = Array.new(@count, beer_stuffs)
  end
end
