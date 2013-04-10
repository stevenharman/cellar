module Settings
  class ProfilesController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def show
      @profile = Profile.new(current_cellar)
    end

    def update
      redirect_to settings_profile_path
    end

  end
end

