# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Don't initialize to apease Heroku's lack of DB connection during slug complilation.
Rails.application.config.assets.initialize_on_precompile = false

# Allow CORS requests for assets
Rails.application.config.middleware.insert 0, Rack::Cors, logger: Rails.logger do
  allow do
    origins '*'
    resource '/assets/*',
      headers: :any,
      methods: [:get, :options]
  end
end

