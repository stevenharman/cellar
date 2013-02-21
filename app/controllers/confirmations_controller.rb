class ConfirmationsController < ApplicationController
  respond_to :html

  def new
    @user = User.new
  end

  def create
    @user = User.send_confirmation_instructions(user_params)

    if @user.errors.empty?
      respond_with({}, location: new_user_session_path)
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
      respond_with(@user)
    end
  end

  def show
    @user = User.confirm_by_token(params[:confirmation_token])

    if @user.errors.empty?
      sign_in(@user)
      flash[:notice] = t('cellar.confirmations.confirmed', username: @user.username)
      respond_with(@user) do |format|
        format.html { redirect_to after_sign_in_path_for(@user) }
      end
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
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

