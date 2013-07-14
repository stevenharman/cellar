class ErrorsController < ApplicationController

  def not_found
    render_404(env['action_dispatch.exception'])
  end

  def internal_server_error
    render status: 500
  end

end
