class CellarsController < ApplicationController
  before_filter :require_login, except: [:show]

  def show
    @cellar = load_cellar
  end

  def brew
    cellar = load_cellar

    raise ActiveRecord::RecordNotFound unless cellar.keeper == current_user

    @brew = Brew.find(params[:id])
    @beers = cellar.fetch_beers_for_brew(@brew)
  end

end
