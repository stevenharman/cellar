class Heartbeat

  def breweries
    @breweries ||= Brewery.count
  end

  def brews
    @brews ||= Brew.count
  end

  def all_time_beers
    @all_time_beers ||= Beer.count
  end

  def cellared_beers
    @cellared_beers ||= Beer.cellared.count
  end

  def cellars
    @cellars ||= User.count
  end

end
