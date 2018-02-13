# frozen_string_literal: true

class VariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :by_barcode

  # GET /variants
  def index
    @variants = current_user.variants
    @variants = @variants.where(product_id: params[:product_id]) if params[:product_id].present?

    render json: @variants
  end

  # GET /variants/1
  def show
    render json: @variant
  end

  # POST /variants
  def create
    if @variant.save
      render json: @variant, status: :created, location: @variant
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /variants/1
  def update
    if @variant.update(update_params)
      render json: @variant
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  def by_barcode
    @variant = current_user.variants.find_by!(barcode: params[:id])
    render json: @variant
  end

  private

  def create_params
    params.require(:variant).permit(
      :original_barcode,
      :buying_price,
      :tax_free_price,
      :provider_id,
      :product_id,
      :default,
      :ratio
    )
  end

  def update_params
    params.require(:variant).permit(:buying_price, :tax_free_price, :provider_id, :product_id, :default, :ratio)
  end
end
