class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.all
  end

  def new
    @brewery = Brewery.new
  end

  def create
    if @brewery = Brewery.create(params[:brewery])
      redirect_to(brewery_path(@brewery), notice: "Thanks for adding #{@brewery.name}!")
    elsif
      render :new
    end
  end

  def show
    @brewery = Brewery.find(params[:id])
  end

end
