class CellarsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @cellar = load_cellar
  end

end
