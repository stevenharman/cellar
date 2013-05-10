class BrewsController < ApplicationController

  def index
    @brews = paginate(Brew.order(:name), page: page_number)
  end

  def show
    @brew = Brew.find(params[:id]).decorate
  end

  private

  def page_number
    params[:page]
  end

end
