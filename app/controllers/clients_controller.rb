# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :search

  # GET /clients
  def index
    @clients = current_user.clients
    @clients = @clients.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @clients
  end

  def search
    @clients = current_user.clients
    @clients = @clients.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @clients.search(params[:query])
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(update_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:client).permit(:firstname, :lastname, :email, :phone, :address, :notes, :store_id)
  end

  def update_params
    params.require(:client).permit(:firstname, :lastname, :email, :phone, :address, :notes)
  end
end
