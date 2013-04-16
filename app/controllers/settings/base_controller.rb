module Settings
  class BaseController < ApplicationController
    layout 'settings'
    before_filter :authenticate_user!

    def current_profile
      @profile ||= current_cellar.profile
    end
    helper_method :current_profile

  end
end
