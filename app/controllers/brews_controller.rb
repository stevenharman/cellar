class BrewsController < ApplicationController

  def index
    @brews = Brew.all
  end

  def show
    @brew = Brew.find(params[:id])
  end

  def new
    @brew = Brew.new
    @brew.brewery_id = params[:brewery]
  end

  def create
    brewery = Brewery.find_by_id(params[:brew][:brewery_id])
    @brew = brewery.brews.build(params[:brew].except(:brewery_id))

    if @brew.save
      redirect_to(brew_path(@brew), notice: "Thanks for adding #{@brew.name}!")
    elsif
      flash.now[:alert] = "Oops! #{@brew.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def edit
    @brew = Brew.find(params[:id])
  end

  def update
    @brew = Brew.find(params[:id])

    if @brew.update_attributes(params[:brew])
      redirect_to brew_path @brew
    else
      flash.now[:alert] = "Oops! #{@brew.errors.full_messages.join(", ")}"
      render :edit
    end
  end

end
