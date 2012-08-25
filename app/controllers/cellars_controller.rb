class CellarsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @cellar = CellarDecorator.new(load_cellar)
  end

end
