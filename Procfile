# === Run on both Heroku and local dev boxen
web:  bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -c $SIDEKIQ_CONCURRENCY

# === Required for local dev boxen
redis: redis-server ./config/redis.conf
mailcatcher: bundle exec mailcatcher -f
