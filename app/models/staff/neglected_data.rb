module Staff
  class NeglectedData
    def initialize(brewery_list: Brewery, brew_list: Brew)
      @brewery_list = brewery_list
      @brew_list = brew_list
    end

    def brews
      @brews ||= @brew_list.neglected
    end

    def breweries
      @breweries ||= @brewery_list.neglected
    end
  end
end
