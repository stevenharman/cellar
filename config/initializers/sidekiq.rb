current_web_concurrency = Proc.new do
  web_concurrency = ENV['WEB_CONCURRENCY']
  web_concurrency ||= Puma.respond_to?(:cli_config) && Puma.cli_config.options.fetch(:max_threads)
  web_concurrency || 16
end

local_redis_url = Proc.new do
  config_file = File.join(File.expand_path('../..', __FILE__), 'redis.conf')
  port = File.read(config_file).chomp.split.last
  "redis://localhost:#{port}"
end

ENV['REDISTOGO_URL'] ||= local_redis_url.call

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar' }

  Rails.application.config.after_initialize do
    ActiveRecord::Base.connection_pool.disconnect!

    ActiveSupport.on_load(:active_record) do
      config = Rails.application.config.database_configuration[Rails.env]
      config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
      config['pool'] = ENV['WORKER_DB_POOL_SIZE'] || Sidekiq.options[:concurrency]
      ActiveRecord::Base.establish_connection(config)

      Rails.logger.info("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }

  Rails.application.config.after_initialize do
    ActiveRecord::Base.connection_pool.disconnect!

    ActiveSupport.on_load(:active_record) do
      config = Rails.application.config.database_configuration[Rails.env]
      config['reaping_frequency'] = ENV['DATABASE_REAP_FREQ'] || 10 # seconds
      config['pool'] = ENV['WEB_DB_POOL_SIZE'] || current_web_concurrency.call
      ActiveRecord::Base.establish_connection(config)

      Rails.logger.info("Connection Pool size for web server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
    end
  end
end
