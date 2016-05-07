class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'record not found' }, status: 404
    nil
  end

  rescue_from NameError, with: :error_occurred
  rescue_from ActionController::RoutingError, with: :error_occurred
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  protected

  def error_occurred(exception)
    render json: { error: exception.message }.to_json, status: 500
    nil
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
    nil
  end
end
