local_redis_url = Proc.new do
  config_file = File.join(File.expand_path('../..', __FILE__), 'redis.conf')
  port = File.read(config_file).chomp.split.last
  "redis://localhost:#{port}"
end

ENV['REDISTOGO_URL'] ||= local_redis_url.call

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar' }

  sidekiq_concurrency = ENV['SIDEKIQ_CONCURRENCY']
  if(sidekiq_concurrency)
    Rails.logger.warn("Setting custom connection pool size of #{sidekiq_concurrency} for Sidekiq Server...")
    Rails.logger.warn("ActiveRecord::Base.connection_pool size = #{ActiveRecord::Base.connection_pool.instance_variable_get('@size')}")
    ActiveRecord::Base.connection_pool.instance_variable_set('@size', sidekiq_concurrency.to_i)
    Rails.logger.warn("ActiveRecord::Base.connection_pool size = #{ActiveRecord::Base.connection_pool.instance_variable_get('@size')}")
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }
end
