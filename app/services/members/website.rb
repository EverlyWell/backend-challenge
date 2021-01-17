# frozen_string_literal: true

module Members
  module Website
    HEADING_EXTRACTION_SERVICE_ERRORS = {
      connection_failed: 200,
      creation_failed: 201,
      heading_persist_failed: 203
    }.freeze

    URL_SHORTENER_SERVICE_ERRORS = {
      connection_failed: 100,
      creation_failed: 101,
      parsing_failed: 102,
      short_url_missing: 103,
      short_url_persist_failed: 104
    }.freeze
  end
end
