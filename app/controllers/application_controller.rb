class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  rescue_from ArgumentError do |exception|
    render json: { errors: [exception] }, status: :unprocessable_entity
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: [exception] }, status: :unauthorized
  end
end
