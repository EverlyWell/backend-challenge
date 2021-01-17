# frozen_string_literal: true

ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'API' # Do not use, breaks rspec_api_documentation formatters
  inflect.acronym 'HTTP'
  inflect.acronym 'JWT'
end
