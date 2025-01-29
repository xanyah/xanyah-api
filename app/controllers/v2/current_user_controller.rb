# frozen_string_literal: true

module V2
  class CurrentUserController < BaseController
    def update
      current_user.update(update_params)

      render json: current_user
    end

    private

    def update_params
      params.expect(user: %i[email password firstname lastname locale])
    end
  end
end
