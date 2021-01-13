class ApplicationController < ActionController::API
  private

  def render_app_error_code(code_id:, detail: nil, source: nil, status: nil)
    error_code = Rails.configuration.x.error_codes.fetch(code_id.to_sym)

    render_app_error(
      code: code_id,
      detail: detail || error_code[:detail],
      source: source,
      status: status || error_code[:http_status],
      title: error_code[:title]
    )
  end

  def render_app_error(code:, detail:, source: nil, status: :not_found, title: nil)
    err = { code: code, detail: detail, status: status }
    err[:source] = source if source
    err[:title] = title if title

    render json: { errors: [err] }, status: status.to_sym
  end

  def render_api_errors(errors:, status:)
    render json: { errors: errors }, status: status.to_sym
  end
end
