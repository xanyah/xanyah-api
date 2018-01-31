# frozen_string_literal: true

class ProvidersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /providers
  def index
    @providers = current_user.stores.map(&:providers).flatten
    render json: @providers
  end

  # GET /providers/1
  def show
    render json: @provider
  end

  # POST /providers
  def create
    if @provider.save
      render json: @provider, status: :created
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /providers/1
  def update
    if @provider.update(update_params)
      render json: @provider
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:provider).permit(:name, :notes, :store_id)
  end

  def update_params
    params.require(:provider).permit(:name, :notes)
  end
end
