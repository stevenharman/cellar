class BrewsController < ApplicationController

  def index
    @brews = Brew.order(:name).page(params[:page])
  end

  def show
    @brew = Brew.find(params[:id])
    @cellar = current_cellar
  end

end
