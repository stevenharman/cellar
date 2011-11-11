class BeersController < ApplicationController

  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def new
    @beer = Beer.new
    @beer_count = 1
    @brews = Brew.all
  end

  def create
    order = BeerOrder.new(params[:count].to_i, params[:beer])
    adds_beers = AddsBeerToCellar.new(order)
    receipt = adds_beers.fulfill

    if receipt.success?
      redirect_to(beers_path, notice: "#{order.count} cellared!")
    elsif
      @beer = receipt.example_beer
      @beer_count = order.count
      @brews = Brew.all

      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])

    if @beer.update_attributes(params[:beer])
      redirect_to beer_path @beer
    else
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :edit
    end
  end

end
