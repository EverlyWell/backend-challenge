# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
end

require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# We only load config stuff we need globally, the rest of helpers/shared examples/etc. should be loaded
# where used to increase test suite boot times.
#
# See Conventions section, item no. 2: https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
#
Dir[Rails.root.join('spec', 'config', '**', '*.rb')].sort.each { |f| require f }

Rails.application.routes.disable_clear_and_finalize = true

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
