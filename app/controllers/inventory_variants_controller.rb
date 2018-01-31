# frozen_string_literal: true

class InventoryVariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /inventory_variants
  def index
    @inventory_variants = current_user.stores.map(&:inventory_variants).flatten

    render json: @inventory_variants
  end

  # GET /inventory_variants/1
  def show
    render json: @inventory_variant
  end

  # POST /inventory_variants
  def create
    if @inventory_variant.save
      render json: @inventory_variant, status: :created, location: @inventory_variant
    else
      render json: @inventory_variant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /inventory_variants/1
  def update
    if @inventory_variant.update(update_params)
      render json: @inventory_variant
    else
      render json: @inventory_variant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /inventory_variants/1
  def destroy
    @inventory_variant.destroy
  end

  private

  def create_params
    params.require(:inventory_variant).permit(:quantity, :inventory_id, :variant_id)
  end

  def update_params
    params.require(:inventory_variant).permit(:quantity)
  end
end
