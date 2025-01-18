# frozen_string_literal: true

class VariantAttributesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /variant_attributes
  def index
    @variant_attributes = current_user.variant_attributes
    @variant_attributes = @variant_attributes.where(variant_id: params[:variant_id]) if params[:variant_id].present?

    render json: @variant_attributes
  end

  # GET /variant_attributes/1
  def show
    render json: @variant_attribute
  end

  # POST /variant_attributes
  def create
    if @variant_attribute.save
      render json: @variant_attribute, status: :created, location: @variant_attribute
    else
      render json: @variant_attribute.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /variant_attributes/1
  def update
    if @variant_attribute.update(update_params)
      render json: @variant_attribute
    else
      render json: @variant_attribute.errors, status: :unprocessable_entity
    end
  end

  # DELETE /variant_attributes/1
  def destroy
    @variant_attribute.destroy
  end

  private

  def create_params
    params.expect(variant_attribute: %i[variant_id custom_attribute_id value])
  end

  def update_params
    params.expect(variant_attribute: [:value])
  end
end
