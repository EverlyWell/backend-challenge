# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/fixtures/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock, :faraday
end
