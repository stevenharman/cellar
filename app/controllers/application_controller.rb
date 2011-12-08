class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def load_cellar
    keeper = User.for_username!(params[:user_id] || params[:username])
    Cellar.new(keeper)
  end

  def not_authenticated
    redirect_to sign_in_path, :alert => "Please sign in first."
  end

  private

  def render_404(exception=nil)
    render template: "errors/404", status: 404
  end

end
