# frozen_string_literal: true

module V2
  class BaseController < ActionController::API
    include Pundit::Authorization
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    rescue_from ArgumentError do |exception|
      render json: { errors: [exception] }, status: :unprocessable_entity
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      Rails.logger.error(e)
      head :unauthorized
    end
  end
end
