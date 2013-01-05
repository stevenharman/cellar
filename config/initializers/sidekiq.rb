local_redis_url = Proc.new do
  config_file = File.join(File.expand_path('../..', __FILE__), 'redis.conf')
  port = File.read(config_file).chomp.split.last
  "redis://localhost:#{port}"
end

ENV['REDISTOGO_URL'] ||= local_redis_url.call

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar' }

  database_url = ENV['DATABASE_URL']
  sidekiq_concurrency = ENV['SIDEKIQ_CONCURRENCY']
  if(database_url && sidekiq_concurrency)
    Rails.logger.warn("Setting custom connection pool size of #{sidekiq_concurrency} for Sidekiq Server...")
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{sidekiq_concurrency}"
    Rails.logger.warn("DATABASE_URL = #{ENV['DATABASE_URL']}")
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }
end
