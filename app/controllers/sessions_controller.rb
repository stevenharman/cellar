class SessionsController < ApplicationController

  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, notice: "Welcome back to the Cellar"
    else
      flash.now.alert = "Username or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "You have been signed out."
  end

end
