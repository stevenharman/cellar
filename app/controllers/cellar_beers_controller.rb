class CellarBeersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_beer, only: [:show, :edit, :update, :drink]

  def show
  end

  def edit
  end

  def update
    if @beer.update_attributes(params[:beer])
      redirect_to cellar_beer_path(@beer.user, @beer)
    else
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  def drink
    @beer.drink!
    redirect_to cellar_brew_path(@cellar.keeper, @beer.brew)
  end

  private

  def load_beer
    @cellar = load_cellar
    @beer = @cellar.find_beer(params[:id])

    fail ActiveRecord::RecordNotFound unless @beer.cellared_by?(current_user)
  end

end

