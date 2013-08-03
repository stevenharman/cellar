class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  before_filter :set_mobile_preference
  before_filter :prepend_view_path_if_mobile

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

  def mobile_browser?
    user_agent = request.env['HTTP_USER_AGENT']
    user_agent =~ /iPhone|Android.*Mobile|IEMobile/
  end
  helper_method :mobile_browser?

  def mobile_request?
    prefer_mobile? || (mobile_browser? && !prefer_desktop?)
  end

  def paginate(collection, options = {})
    options = { per_page: DEFAULT_PER_PAGE }.merge(options)
    paged_collection = collection.page(options[:page]).per(options[:per_page])

    PaginatingDecorator.decorate(paged_collection)
  end

  def prefer_desktop?
    cookies[:mobile] == '0'
  end
  helper_method :prefer_desktop?

  def prefer_mobile?
    cookies[:mobile] == '1'
  end

  def prepend_view_path_if_mobile
    prepend_view_path Rails.root.join('app/views/mobile') if mobile_request?
  end

  def render_404(exception=nil)
    render template: 'errors/not_found', status: 404
  end

  def set_mobile_preference
    mobile_override = params[:mobile]

    if mobile_override
      cookies.permanent[:mobile] = mobile_override
      redirect_to params.except(:mobile)
    end
  end

end
