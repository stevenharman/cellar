class CellarBeerStatusController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def update
    beer = current_cellar.find_beer(params[:beer_id])
    unless beer.update_attributes(params.slice(:status))
      flash[:alert] = "Oops! #{beer.errors.full_messages.join(", ")}"
    end

    respond_with beer, location: brew_path(beer.brew)
  end
end

