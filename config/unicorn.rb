worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout 15
preload_app true
listen ENV['PORT'], backlog: Integer(ENV['UNICORN_BACKLOG'] || 200)

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], namespace: 'brewdega-cellar', :size => 1 }
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
