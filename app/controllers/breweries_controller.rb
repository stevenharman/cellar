class BreweriesController < ApplicationController

  def index
    @breweries = paginate(Brewery.order(:name), page: page_number)
  end

  def show
    @brewery = Brewery.find(params[:id]).decorate
  end

  private

  def page_number
    params[:page]
  end

end
