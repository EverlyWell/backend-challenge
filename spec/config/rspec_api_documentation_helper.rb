# frozen_string_literal: true

require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.configurations_dir = Rails.root.join('docs', 'configurations', 'api')
  config.docs_dir = Rails.root.join('docs', 'api')
  config.format = %i[html open_api]
  config.curl_host = 'http://localhost:3000'
  config.curl_headers_to_filter = nil
  config.request_headers_to_include = nil
  config.response_headers_to_include = nil
  config.api_name = 'Backend Challenge API Documentation'
  config.api_explanation = 'Backend Challenge API Description'
  config.client_method = :http_client

  config.define_group :public do |config|
    # By default the group's doc_dir is a subfolder under the parent group, based
    # on the group's name.
    config.docs_dir = Rails.root.join('docs', 'api', 'public')

    # Change the filter to only include :public examples
    config.filter = :public
  end
end
