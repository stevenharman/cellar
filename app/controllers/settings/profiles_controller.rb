module Settings
  class ProfilesController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def show
      @profile = Profile.new(current_cellar)
    end

    def update
      @profile = Profile.new(current_cellar)

      if @profile.update(profile_params)
        flash[:notice] = t('flash.profile.update.notice')
        respond_with @profile, location: settings_profile_path
      else
        flash.now[:alert] = t('flash.profile.update.alert')
        render :show, status: :unprocessable_entity
      end

    end

    private

    def profile_params
      params[:profile].slice(:bio, :location, :website)
    end
  end
end

