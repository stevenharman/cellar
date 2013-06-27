class CellarBeersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_requested_cellar_for_current_user
  respond_to :html

  def show
    @beer= find_beer(params[:id])
  end

  def edit
    @beer= find_beer(params[:id])
  end

  def update
    @beer= find_beer(params[:id])

    if @beer.update_attributes(beer_params)
      flash[:success] = t('flash.cellar_beers.update.success', name: @beer.brew.name)
    else
      flash[:error] = t('flash.cellar_beers.update.error', name: @beer.brew.name)
    end

    respond_with(@beer, location: cellar_beer_path(@beer.user, @beer))
  end

  private

  def authorize_requested_cellar_for_current_user
    fail ActiveRecord::RecordNotFound unless requested_cellar.kept_by?(current_user)
  end

  def beer_params
    params[:beer].slice(:batch, :best_by, :vintage, :notes)
  end

  def find_beer(beer_id)
    BeerDecorator.new(requested_cellar.find_beer(beer_id))
  end

end
