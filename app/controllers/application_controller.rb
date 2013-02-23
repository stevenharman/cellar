class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def current_user
    @decorated_current_user ||= (UserDecorator.new(super) if super)
  end

  protected

  def current_cellar
    @decorated_current_cellar ||=
      CellarDecorator.new(Cellar.new(current_user))
  end

  def load_cellar
    keeper = User.for_username!(params[:cellar_id] || params[:username])
    Cellar.new(keeper)
  end

  def not_authenticated
    redirect_to new_user_session_path, :alert => 'Please sign in first.'
  end

  def redirect_if_already_signed_in
    redirect_to root_path if signed_in?
  end

  private

  def render_404(exception=nil)
    render template: 'errors/404', status: 404
  end

end
