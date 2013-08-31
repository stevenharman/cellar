# === Run on both Heroku and local dev boxen
web: bundle exec puma -b tcp://0.0.0.0:$PORT -t 0:${WEB_CONCURRENCY:-16} -e ${RACK_ENV:-development}
worker: bundle exec sidekiq -c ${WORKER_CONCURRENCY:-25}

# === Required for local dev boxen
redis: redis-server ./config/redis.conf
mailcatcher: bundle exec mailcatcher -f
