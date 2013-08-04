class UsersController < ApplicationController
  before_filter :redirect_if_already_signed_in, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, flash: { success: t('flash.users.create.success', email: @user.email) }
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
