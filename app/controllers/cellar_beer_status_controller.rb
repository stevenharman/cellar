class CellarBeerStatusController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def update
    beer = current_cellar.find_beer(params[:beer_id])
    if beer.update_attributes(params.slice(:status))
      flash[:notice] = "That #{beer.brew.name} was #{beer.status}!"
    else
      flash[:alert] = beer.errors.full_messages.join(". ")
    end

    respond_with beer, location: brew_path(beer.brew)
  end
end

