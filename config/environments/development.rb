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
  
  DOORKEEPER_APP_ID = '2b51a11c29e3eacd02a48eadde429de194ab2291516946b2dd4e6d5306ec7988'
  DOORKEEPER_APP_SECRET = '94ef88bb3fcd2919fec6cb6c3822738c8b0da75006fba711f31c240e4aa11f6e'
  DOORKEEPER_APP_URL = "http://localhost:3000"
  DOORKEEPER_CALLBACK_URL = "http://localhost:3001/logins/authorize"
end
