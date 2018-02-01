# frozen_string_literal: true

class ShippingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /shippings
  def index
    @shippings = current_user.stores.map(&:shippings).flatten

    render json: @shippings
  end

  # GET /shippings/1
  def show
    render json: @shipping
  end

  # POST /shippings
  def create
    if @shipping.save
      render json: @shipping, status: :created, location: @shipping
    else
      render json: @shipping.errors, status: :unprocessable_entity
    end
  end

  def lock
    if @shipping.lock
      render json: @shipping
    else
      render json: @shipping.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shippings/1
  def destroy
    @shipping.destroy
  end

  private

  def create_params
    params.require(:shipping).permit(:store_id)
  end
end
