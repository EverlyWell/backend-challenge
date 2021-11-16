class ApplicationController < ActionController::API
  include JsonErrorRendering
  include JSONAPI::ActsAsResourceController
end
