class CellarsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @cellar = CellarDecorator.new(requested_cellar)
  end

end
