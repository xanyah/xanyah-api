# frozen_string_literal: true

module V2
  class ShippingVariantsController < ResourcesController
    def lock
      authorize @record

      if @record.lock
        render json: @record
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end
  end
end
