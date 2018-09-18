# frozen_string_literal: true

class PaymentTypesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /payment_types
  def index
    @payment_types = current_user.payment_types
    @payment_types = @payment_types.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @payment_types
  end

  # GET /payment_types/1
  def show
    render json: @payment_type
  end

  # POST /payment_types
  def create
    if @payment_type.save
      render json: @payment_type, status: :created
    else
      render json: @payment_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_types/1
  def update
    if @payment_type.update(update_params)
      render json: @payment_type
    else
      render json: @payment_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @payment_type.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:payment_type).permit(:name, :description, :store_id)
  end

  def update_params
    params.require(:payment_type).permit(:name, :description)
  end
end
