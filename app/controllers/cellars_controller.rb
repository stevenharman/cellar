class CellarsController < ApplicationController
  before_filter :require_login, except: [:show]

  def show
    cellar_keeper = User.for_username!(params[:username])
    @cellar = Cellar.new(cellar_keeper)
  end

  def brew

  end

end
