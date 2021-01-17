# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/fixtures/vcr_cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock, :faraday


  c.filter_sensitive_data('Bearer [BITLY_API_KEY]') do |interaction|
    interaction.request.headers['Authorization']&.first if /bitly/.match?(interaction.request.uri)
  end
end
