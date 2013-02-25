class BrewsController < ApplicationController

  def index
    @brews = Brew.order(:name).page(params[:page])
  end

  def show
    brew = Brew.find(params[:id])
    @brew = CellaredBrewDecorator.new(brew, context: {cellar: current_cellar})
  end

end
