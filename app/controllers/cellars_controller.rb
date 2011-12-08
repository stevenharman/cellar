class CellarsController < ApplicationController
  before_filter :require_login, except: [:show]

  def show
    cellar_keeper = User.for_username!(params[:username])
    @cellar = Cellar.new(cellar_keeper)
  end

  def brew
    cellar_keeper = User.for_username!(params[:user_id])
    cellar = Cellar.new(cellar_keeper)

    raise ActiveRecord::RecordNotFound unless cellar.keeper == current_user

    @brew = Brew.find(params[:id])
    @beers = cellar.fetch_beers_for_brew(@brew)
  end

end
