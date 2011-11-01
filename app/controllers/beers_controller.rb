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
    @beer_count = params[:count].to_i
    brew = Brew.find_by_id(params[:beer][:brew_id])

    new_beers = (0...@beer_count).collect do |i|
      Beer.create(params[:beer]) do |b|
        b.brew = brew
      end
    end

    if new_beers.all?(&:valid?)
      redirect_to(beers_path, notice: "#{brew.name} has been cellared!")
    elsif
      @beer = new_beers.find(&:invalid?)
      @brews = Brew.all
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"

      new_beers.map { |b| b.delete }
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
