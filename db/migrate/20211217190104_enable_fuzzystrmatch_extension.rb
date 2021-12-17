class EnableFuzzystrmatchExtension < ActiveRecord::Migration[6.1]
  # The fuzzystrmatch module provides several functions to determine similarities and
  # distance between strings
  def change
    enable_extension 'fuzzystrmatch' unless extension_enabled?('fuzzystrmatch')
  end
end
