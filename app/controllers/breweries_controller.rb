class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.order(:name).page(params[:page])
  end

  def show
    @brewery = Brewery.find(params[:id])
  end

end
