# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /products
  def index # rubocop:disable Metrics/AbcSize
    @products = current_user.products
    @products = @products.where(store_id: params[:store_id]) if params[:store_id].present?
    @products = @products.where(manufacturer_id: params[:manufacturer_id]) if params[:manufacturer_id].present?
    if params[:provider_id].present?
      @products = @products.joins(:variants)
      @products = @products.where(variants: { provider_id: params[:provider_id] })
    end

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    if @product.save
      @variant = Variant.create(variant_params)
      @variant.product = @product
      if @variant.save
        render json: @variant, status: :created, location: @product
      else
        render json: @variant.errors, status: :unprocessable_entity
      end
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(update_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:product).permit(:name, :category_id, :manufacturer_id, :store_id)
  end

  def variant_params
    params.require(:variant).permit(:buying_price, :original_barcode, :tax_free_price, :provider_id, :ratio)
  end

  def update_params
    params.require(:product).permit(:name, :category_id, :manufacturer_id)
  end
end
