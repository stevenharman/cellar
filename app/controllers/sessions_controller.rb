class SessionsController < ApplicationController
  before_filter :redirect_if_already_signed_in, only: :new
  before_filter :allow_params_authentication!, only: :create

  def new
    @user = User.new(params[:user])
  end

  def create
    user = authenticate_user!(:recall => 'sessions#new')
    sign_in user
    redirect_to after_sign_in_path_for(user), flash: { success: t('flash.sessions.create.success', name: user.username) }
  end

  def destroy
    sign_out
    redirect_to root_path, flash: { success: t('flash.sessions.destroy.success') }
  end

end
