# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :search

  # GET /customers
  def index
    @customers = current_user.customers
    @customers = @customers.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @customers
  end

  def search
    @customers = current_user.customers
    @customers = @customers.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @customers.search(params[:query])
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(update_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.expect(customer: %i[firstname lastname email phone address notes store_id])
  end

  def update_params
    params.expect(customer: %i[firstname lastname email phone address notes])
  end
end
