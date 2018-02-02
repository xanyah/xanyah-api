# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /products
  def index
    @products = current_user.stores.map(&:products).flatten
    @products = @products.select {|c| c.store_id == params[:store_id] } if params[:store_id].present?

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    if @product.save
      render json: @product, status: :created, location: @product
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

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:product).permit(:name, :category_id, :manufacturer_id, :store_id)
  end

  def update_params
    params.require(:product).permit(:name, :category_id, :manufacturer_id)
  end
end
