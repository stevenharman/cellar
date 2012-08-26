class BeersController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @beers = Beer.includes(:brew).order('brews.name')
  end

  def new
    brew_id = params[:brew]
    return redirect_to brews_path unless brew_id

    @beer = Brew.find(brew_id).beers.build
    @beer_count = 1
  end

  def create
    cellar = Cellar.new(current_user)
    order = BeerOrder.new(params[:count].to_i, params[:beer])
    receipt = cellar.stock_beer(order)

    if receipt.success?
      redirect_to(cellar_path(current_user), notice: "#{order.count} cellared!")
    else
      @beer = receipt.example_beer
      @beer_count = order.count
      @brews = Brew.all

      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :new
    end
  end

end
