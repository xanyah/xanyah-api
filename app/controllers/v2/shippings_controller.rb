# frozen_string_literal: true

module V2
  class ShippingsController < ResourcesController
    def validate
      authorize @record

      if @record.validate
        render json: @record
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end

    def rollback
      authorize @record

      if @record.rollback
        render json: @record
      else
        render json: @record.errors, status: :unprocessable_entity
      end
    end
  end
end
