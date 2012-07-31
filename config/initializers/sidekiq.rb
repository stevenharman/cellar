ENV['REDISTOGO_URL'] ||= 'redis://localhost:6380' # same as config/redis.conf

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }
end
