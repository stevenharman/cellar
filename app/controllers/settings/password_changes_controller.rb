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
        flash[:success] = t('flash.password_change.create.success')
        bypass_sign_in(current_user)
      else
        flash.now[:error] = t('flash.password_change.create.error')
      end

      respond_with(@password_change, location: settings_profile_path)
    end

    private

    def change_params
      params.require(:settings_password_change).permit(:new, :current)
    end
  end
end
