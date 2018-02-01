# frozen_string_literal: true

class StoresController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /stores
  def index
    @stores = current_user.stores
    render json: @stores
  end

  # GET /stores/1
  def show
    render json: @store
  end

  # POST /stores
  def create
    if @store.save
      StoreMembership.create(user: current_user, store: @store)
      render json: @store, status: :created
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(update_params)
      render json: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:store).permit(:name, :address, :country, :key)
  end

  def update_params
    params.require(:store).permit(:name, :address, :country)
  end
end
