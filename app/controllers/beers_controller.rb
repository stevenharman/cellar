class BeersController < ApplicationController
  before_filter :require_login, except: [:index]
  before_filter :load_beer, only: [:show, :edit, :update, :drink]

  def index
    @beers = Beer.includes(:brew).order('brews.name')
  end

  def new
    @beer = Beer.new
    @beer_count = 1
    @brews = Brew.all
  end

  def create
    cellar = Cellar.new(current_user)
    order = BeerOrder.new(params[:count].to_i, params[:beer])
    receipt = cellar.stock_beer(order)

    if receipt.success?
      redirect_to(cellar_path(current_user), notice: "#{order.count} cellared!")
    elsif
      @beer = receipt.example_beer
      @beer_count = order.count
      @brews = Brew.all

      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @beer.update_attributes(params[:beer])
      redirect_to [@beer.user, @beer]
    else
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  def drink
    @beer.drink!
    redirect_to user_brew_path(@cellar.keeper, @beer.brew)
  end

  private

  def load_beer
    @cellar = load_cellar
    @beer = @cellar.find_beer(params[:id])

    fail ActiveRecord::RecordNotFound unless @beer.owned_by?(current_user)
  end

end
