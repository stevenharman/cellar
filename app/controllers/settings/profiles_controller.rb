module Settings
  class ProfilesController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def edit
      @profile = Profile.new(current_cellar)
      respond_with(@profile)
    end

    def update
      @profile = Profile.new(current_cellar)

      if @profile.update(profile_params)
        flash[:notice] = t('flash.profile.update.notice')
      else
        flash.now[:alert] = t('flash.profile.update.alert')
      end

      respond_with @profile, location: settings_profile_path
    end

    private

    def profile_params
      params[:profile].slice(:bio, :location, :website)
    end
  end
end

