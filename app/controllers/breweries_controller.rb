class BreweriesController < ApplicationController

  def index
    paged_breweries = Brewery.order(:name).page(params[:page])
    @breweries = BreweryDecorator.decorate(paged_breweries)
  end

  def show
    @brewery = Brewery.find(params[:id]).decorate
  end

end
