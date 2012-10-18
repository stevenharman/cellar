class CellarBeersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @beer = load_cellar.find_beer(params[:id])
    fail ActiveRecord::RecordNotFound unless @beer.cellared_by?(current_user)
  end

end
