# frozen_string_literal: true

module V2
  class OrdersController < ResourcesController
    def cancel
      authorize @record, :update?

      if @record.update(status: :canceled)
        render json: @record
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end
  end
end
