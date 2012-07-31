# === Run on both Heroku and local dev boxen
web:  bundle exec rails server thin -p $PORT
worker: bundle exec sidekiq -c 5

# === Required for local dev boxen
redis: redis-server config/redis.conf
