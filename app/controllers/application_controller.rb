class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def not_authenticated
    redirect_to sign_in_path, :alert => "Please sign in first."
  end
end
