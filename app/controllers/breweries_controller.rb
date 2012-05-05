class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.all
  end

  def new
    @brewery = Brewery.new
  end

  def create
    @brewery = Brewery.create(params[:brewery])
    if @brewery.valid?
      redirect_to(brewery_path(@brewery), notice: "Thanks for adding #{@brewery.name}!")
    else
      flash.now[:alert] = "Oops! #{@brewery.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def show
    @brewery = Brewery.find(params[:id])
  end

end
