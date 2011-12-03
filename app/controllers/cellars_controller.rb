class CellarsController < ApplicationController

  def show
    cellar_keeper = User.for_username!(params[:username])
    @cellar = Cellar.new(cellar_keeper)
  end

end
