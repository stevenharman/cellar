class CellarBeersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_requested_cellar_for_current_user

  def show
    @beer = requested_cellar.find_beer(params[:id])
  end

  private

  def authorize_requested_cellar_for_current_user
    fail ActiveRecord::RecordNotFound unless requested_cellar.kept_by?(current_user)
  end

end
