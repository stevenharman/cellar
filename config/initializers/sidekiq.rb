local_redis_url = Proc.new do
  config_file = File.join(File.expand_path('../..', __FILE__), 'redis.conf')
  port = File.read(config_file).chomp.split.last
  "redis://localhost:#{port}"
end

ENV['REDISTOGO_URL'] ||= local_redis_url.call

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar' }

  BrewdegaCellar.override_db_connection_pool_size!(Sidekiq.options[:concurrency])

  Rails.logger.info("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }
end
