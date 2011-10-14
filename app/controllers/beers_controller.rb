class BeersController < ApplicationController

  def new
    @beer = Beer.new
    @brews = Brew.all
  end

  def create
    brew = Brew.find_by_id(params[:beer][:brew_id])
    @beer = Beer.new(params[:beer]) do |b|
      b.brew = brew
    end

    if @beer.save
      redirect_to(beer_path(@beer), notice: "#{@beer.brew.name} has been cellared!")
    elsif
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      @brews = Brew.all
      render :new
    end
  end

  def show
    @beer = Beer.find(params[:id])
  end

end
