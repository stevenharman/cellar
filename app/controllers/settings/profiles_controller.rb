module Settings
  class ProfilesController < BaseController
    respond_to :html

    def edit
      respond_with(current_profile)
    end

    def update
      if current_profile.update(profile_params)
        flash[:success] = t('flash.profile.update.success')
      else
        flash.now[:error] = t('flash.profile.update.error')
      end

      respond_with current_profile, location: settings_profile_path
    end

    private

    def profile_params
      params[:profile].slice(:bio, :location, :name, :website)
    end
  end
end

