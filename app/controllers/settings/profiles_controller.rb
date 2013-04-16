module Settings
  class ProfilesController < BaseController
    respond_to :html

    def edit
      respond_with(current_profile)
    end

    def update
      if current_profile.update(profile_params)
        flash[:notice] = t('flash.profile.update.notice')
      else
        flash.now[:alert] = t('flash.profile.update.alert')
      end

      respond_with current_profile, location: settings_profile_path
    end

    private

    def profile_params
      params[:profile].slice(:bio, :location, :name, :website)
    end
  end
end

