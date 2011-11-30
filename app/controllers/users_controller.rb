class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "#{@user.username}, welcome to the Cellar!"
    else
      render :new
    end
  end

  def show
    user = User.find_by_username!(params[:username].downcase)
    @cellar = Cellar.new(user)
  end

end
