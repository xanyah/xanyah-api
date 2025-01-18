# frozen_string_literal: true

class SalePromotionsController < ApplicationController
  before_action :set_sale_promotion, only: %i[show update destroy]

  # GET /sale_promotions
  def index
    @sale_promotions = SalePromotion.all

    render json: @sale_promotions
  end

  # GET /sale_promotions/1
  def show
    render json: @sale_promotion
  end

  # POST /sale_promotions
  def create
    @sale_promotion = SalePromotion.new(sale_promotion_params)

    if @sale_promotion.save
      render json: @sale_promotion, status: :created, location: @sale_promotion
    else
      render json: @sale_promotion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sale_promotions/1
  def update
    if @sale_promotion.update(sale_promotion_params)
      render json: @sale_promotion
    else
      render json: @sale_promotion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sale_promotions/1
  def destroy
    @sale_promotion.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sale_promotion
    @sale_promotion = SalePromotion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def sale_promotion_params
    params.expect(sale_promotion: %i[type amount sale_id])
  end
end
