class SessionsController < ApplicationController
  before_filter :allow_params_authentication!, :only => :create

  def new
    @user = User.new(params[:user])
  end

  def create
    user = authenticate_user!(:recall => 'sessions#new')
    sign_in user
    redirect_to root_url, notice: 'Welcome back to the Cellar'
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'You have been signed out.'
  end
end
