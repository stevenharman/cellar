# Usage: in develoopment.rb
#
#   config.middleware.insert_before Rails::Rack::Logger, PeacefulAssetsLogger
#
class PeacefulAssetsLogger
  def initialize(app)
    unless ENV[ 'LOG_ASSETS' ]
      puts 'For more peaceful logs we have silenced the asset logs.'
      puts 'To see asset requests in the logs, set LOG_ASSETS=true env variable.'
      Rails.application.assets.logger = Logger.new('/dev/null')
    end

    @app = app
  end

  def call(env)
    previous_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index('/assets/') == 0 && !ENV['LOG_ASSETS']
    @app.call(env)
  ensure
    Rails.logger.level = previous_level
  end
end
