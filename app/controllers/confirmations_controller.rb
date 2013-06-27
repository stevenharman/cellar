class ConfirmationsController < ApplicationController
  before_filter :redirect_if_already_signed_in, only: :new
  respond_to :html

  def new
    @user = User.new
  end

  def create
    @user = User.send_confirmation_instructions(user_params)

    if @user.valid?
      flash[:success] = t('flash.confirmations.create.success')
      respond_with({}, location: new_user_session_path)
    else
      flash.now[:error] = t('flash.confirmations.create.error')
      respond_with(@user)
    end
  end

  def show
    @user = User.confirm_by_token(params[:confirmation_token])

    if @user.valid?
      sign_in(@user)
      flash[:success] = t('flash.confirmations.show.success', username: @user.username)
      redirect_to after_sign_in_path_for(@user)
    else
      flash.now[:error] = t('flash.confirmations.show.error')
      render :new
    end
  end

  private

  def user_params
    params[:user]
  end
end

