require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shoppe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.middleware.use I18n::JS::Middleware
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.time_zone = ENV["timezone"]
    config.active_record.default_timezone = :local
    config.active_job.queue_adapter = :sidekiq
  end
end
