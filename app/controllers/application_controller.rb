class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  DEFAULT_PER_PAGE = 30

  def current_user
    @decorated_current_user ||= (UserDecorator.new(super) if super)
  end

  def current_cellar
    @decorated_current_cellar ||= decorated_cellar(current_user)
  end
  helper_method :current_cellar

  protected

  def requested_cellar
    @requested_cellar ||= load_cellar(params[:cellar_id] || params[:username])
  end

  def not_authenticated
    flash[:error] = t('flash.application.must_sign_in')
    redirect_to new_user_session_path
  end

  def redirect_if_already_signed_in
    redirect_to root_path if signed_in?
  end

  private

  def decorated_cellar(keeper)
    keeper = keeper || AnonymousUser.new
    CellarDecorator.new(Cellar.find_by(keeper))
  end

  def load_cellar(cellar_name)
    if (current_cellar.name == cellar_name)
      current_cellar
    else
      keeper = User.for_username!(cellar_name)
      decorated_cellar(keeper)
    end
  end

  def paginate(collection, options = {})
    options = { per_page: DEFAULT_PER_PAGE }.merge(options)
    paged_collection = collection.page(options[:page]).per(options[:per_page])

    PaginatingDecorator.decorate(paged_collection)
  end

  def render_404(exception=nil)
    render template: 'errors/404', status: 404
  end

end
