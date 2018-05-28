module Concerns::ErrorHandlers
  extend ::ActiveSupport::Concern

  def render_unauthorized(err)
    render json: { errors: err }, status: :unauthorized
  end

  def render_bad_request(err)
    render json: { errors: err }, status: :bad_request
  end

  def render_unprocessable_entity(err)
    render json: { errors: err }, status: :unprocessable_entity
  end
end
