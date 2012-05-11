class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = login(user_params[:username], user_params[:password], user_params[:remember_me])
    if user
      redirect_back_or_to root_url, notice: "Welcome back to the Cellar"
    else
      @user = User.new(user_params)
      flash.now.alert = "Username or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "You have been signed out."
  end

  private

  def user_params
    @user_params ||= params[:user]
  end

end
