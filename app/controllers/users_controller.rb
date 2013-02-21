class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: t('cellar.registrations.signed_up_but_unconfirmed', email: @user.email)
    else
      render :new
    end
  end

end
