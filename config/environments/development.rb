OwnyourinfodevClient::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true
  
  DOORKEEPER_APP_ID = '80b902fde8dfbcb6362af5b35d3f85063fc6b0abf6b8dbb2571a117567664b1d'
  DOORKEEPER_APP_SECRET = 'dfc99e0154b3f490a46efc0c9ba2dffb880b704606f1620415a225847e15cfc8'
  DOORKEEPER_APP_URL = "http://localhost:3000"
  DOORKEEPER_CALLBACK_URL = "http://localhost:3001/logins/authorize"
end
