class ConfirmationsController < ApplicationController
  before_filter :redirect_if_already_signed_in, only: :new
  respond_to :html

  def new
    @user = User.new
  end

  def create
    @user = User.send_confirmation_instructions(user_params)

    if @user.valid?
      flash[:notice] = t('flash.confirmations.create.notice')
      respond_with({}, location: new_user_session_path)
    else
      flash.now[:alert] = t('flash.confirmations.create.alert')
      respond_with(@user)
    end
  end

  def show
    @user = User.confirm_by_token(params[:confirmation_token])

    if @user.valid?
      sign_in(@user)
      flash[:notice] = t('flash.confirmations.show.notice', username: @user.username)
      respond_with(@user) do |format|
        format.html { redirect_to after_sign_in_path_for(@user) }
      end
    else
      flash.now[:alert] = t('flash.confirmations.show.alert')
      respond_with(@user.errors, status: :unprocessable_entity) do |format|
        format.html { render :new }
      end
    end
  end

  private

  def user_params
    params[:user]
  end
end

