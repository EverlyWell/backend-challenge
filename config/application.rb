require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# require "active_storage/engine"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BackendChallenge
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc
    config.active_job.queue_adapter = :sidekiq
    config.api_only = true

    config.active_record.schema_format = :sql

    # load app error codes
    config.x.error_codes = config_for(:error_codes)
  end
end
