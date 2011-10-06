class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.all
  end

  def new
    @brewery = Brewery.new
  end

end
