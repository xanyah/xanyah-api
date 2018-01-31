# frozen_string_literal: true

class CustomAttributesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /custom_attributes
  def index
    @custom_attributes = current_user.stores.map(&:custom_attributes).flatten

    render json: @custom_attributes
  end

  # GET /custom_attributes/1
  def show
    render json: @custom_attribute
  end

  # POST /custom_attributes
  def create
    if @custom_attribute.save
      render json: @custom_attribute, status: :created, location: @custom_attribute
    else
      render json: @custom_attribute.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /custom_attributes/1
  def update
    if @custom_attribute.update(update_params)
      render json: @custom_attribute
    else
      render json: @custom_attribute.errors, status: :unprocessable_entity
    end
  end

  # DELETE /custom_attributes/1
  def destroy
    @custom_attribute.destroy
  end

  private

  def create_params
    params.require(:custom_attribute).permit(:name, :type, :store_id)
  end

  def update_params
    params.require(:custom_attribute).permit(:name, :type)
  end
end
