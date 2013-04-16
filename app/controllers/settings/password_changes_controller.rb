module Settings
  class PasswordChangesController < BaseController
    respond_to :html

    def new
      @password_change = PasswordChange.new(current_user)
      respond_with(@password_change)
    end

    def create
      @password_change = PasswordChange.new(current_user)
      if @password_change.call(change_params)
        flash[:notice] = t('flash.password_change.create.notice')
        sign_in(current_user, bypass: true)
      else
        flash.now[:alert] = t('flash.password_change.create.alert')
      end

      respond_with(@password_change, location: settings_profile_path)
    end

    private

    def change_params
      params[:settings_password_change].slice(:new, :current)
    end
  end
end
