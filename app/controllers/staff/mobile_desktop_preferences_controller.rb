module Staff
  class MobileDesktopPreferencesController < ApplicationController
    layout 'staff'

    def show
    end

    def destroy
      cookies.delete(:mobile)
      redirect_to staff_mobile_desktop_preference_path, flash: { success: 'Your mobile/desktop preferences have been reset' }
    end

  end
end
