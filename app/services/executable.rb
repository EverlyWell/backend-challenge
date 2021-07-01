module Executable
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Callbacks

    define_model_callbacks :execute

    def self.execute(*args)
      new(*args).execute
    end
  end
end
