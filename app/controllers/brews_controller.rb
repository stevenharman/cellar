class BrewsController < ApplicationController

  def new
    @brew = Brew.new
  end

  def create
    brewery = Brewery.find(params[:brew][:brewery_id])
    @brew = brewery.brews.create(params[:brew])
    if @brew.valid?
      redirect_to(brew_path(@brew), notice: "Thanks for adding #{@brew.name}!")
    elsif
      flash.now[:alert] = "Oops! #{@brew.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def show
    @brew = Brew.find(params[:id])
  end

end
