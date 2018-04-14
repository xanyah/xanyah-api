# frozen_string_literal: true

class SaleVariantPromotionsController < ApplicationController
  before_action :set_sale_variant_promotion, only: %i[show update destroy]

  # GET /sale_variant_promotions
  def index
    @sale_variant_promotions = SaleVariantPromotion.all

    render json: @sale_variant_promotions
  end

  # GET /sale_variant_promotions/1
  def show
    render json: @sale_variant_promotion
  end

  # POST /sale_variant_promotions
  def create
    @sale_variant_promotion = SaleVariantPromotion.new(sale_variant_promotion_params)

    if @sale_variant_promotion.save
      render json: @sale_variant_promotion, status: :created, location: @sale_variant_promotion
    else
      render json: @sale_variant_promotion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sale_variant_promotions/1
  def update
    if @sale_variant_promotion.update(sale_variant_promotion_params)
      render json: @sale_variant_promotion
    else
      render json: @sale_variant_promotion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sale_variant_promotions/1
  def destroy
    @sale_variant_promotion.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sale_variant_promotion
    @sale_variant_promotion = SaleVariantPromotion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def sale_variant_promotion_params
    params.require(:sale_variant_promotion).permit(:type, :amount, :sale_variant_id)
  end
end
