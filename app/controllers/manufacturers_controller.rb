# frozen_string_literal: true

class ManufacturersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /providers
  def index
    @manufacturers = current_user.stores.map(&:manufacturers).flatten
    @manufacturers = @manufacturers.select {|c| c.store_id == params[:store_id] } if params[:store_id].present?

    render json: @manufacturers
  end

  # GET /providers/1
  def show
    render json: @manufacturer
  end

  # POST /providers
  def create
    if @manufacturer.save
      render json: @manufacturer, status: :created
    else
      render json: @manufacturer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /providers/1
  def update
    if @manufacturer.update(update_params)
      render json: @manufacturer
    else
      render json: @manufacturer.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:manufacturer).permit(:name, :notes, :store_id)
  end

  def update_params
    params.require(:manufacturer).permit(:name, :notes)
  end
end
