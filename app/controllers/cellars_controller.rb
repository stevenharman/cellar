class CellarsController < ApplicationController

  def index
    cellar_list = CellarList.new(page: page_number)
    @cellar_list = CellarListDecorator.decorate(cellar_list)
  end

  def show
    @cellar = CellarDecorator.new(requested_cellar)
  end

  private

  def page_number
    params[:page]
  end
end
