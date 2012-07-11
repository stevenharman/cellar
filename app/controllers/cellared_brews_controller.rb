class CellaredBrewsController < ApplicationController
  before_filter :authenticate_user!

  def show
    cellar = load_cellar

    fail ActiveRecord::RecordNotFound unless cellar.kept_by?(current_user)

    @brew = Brew.find(params[:id])
    @beers = cellar.beers_for(@brew)
  end

end
