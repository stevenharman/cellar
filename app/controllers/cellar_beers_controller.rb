class CellarBeersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_beer, only: [:show, :edit, :update, :drink]

  def show
  end

  # TODO Remove edit and generic update as we don't yet use them.
  def edit
  end

  def update
    #if @beer.update_attributes(params[:beer])
    if @beer.update_attributes(params.slice(:status))
      redirect_to brew_path(@beer.brew)
    else
      flash.now[:alert] = "Oops! #{@beer.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  def drink
    @beer.drink!
    redirect_to brew_path(@beer.brew)
  end

  private

  def load_beer
    @cellar = load_cellar
    @beer = @cellar.find_beer(params[:id])

    fail ActiveRecord::RecordNotFound unless @beer.cellared_by?(current_user)
  end

end

