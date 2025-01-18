# frozen_string_literal: true

class ShippingVariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :by_variant

  # GET /shipping_variants
  def index
    @shipping_variants = current_user.shipping_variants
    @shipping_variants = @shipping_variants.where(shipping_id: params[:shipping_id]) if params[:shipping_id].present?

    render json: @shipping_variants
  end

  # GET /shipping_variants/1
  def show
    render json: @shipping_variant
  end

  def by_variant
    @shipping_variant = ShippingVariant.where(
      shipping_id: params[:shipping_id],
      variant_id: params[:variant_id]
    ).first_or_create
    authorize! :create, @shipping_variant
    if @shipping_variant.save
      render json: @shipping_variant
    else
      render json: @shipping_variant.errors, status: :unprocessable_entity
    end
  end

  # POST /shipping_variants
  def create
    if @shipping_variant.save
      render json: @shipping_variant, status: :created, location: @shipping_variant
    else
      render json: @shipping_variant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shipping_variants/1
  def update
    if @shipping_variant.update(update_params)
      render json: @shipping_variant
    else
      render json: @shipping_variant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shipping_variants/1
  def destroy
    @shipping_variant.destroy
  end

  private

  def create_params
    params.expect(shipping_variant: %i[quantity shipping_id variant_id])
  end

  def update_params
    params.expect(shipping_variant: [:quantity])
  end
end
