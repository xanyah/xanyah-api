# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: :search

  # GET /orders
  def index
    @orders = current_user.orders
    @orders = @orders.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @orders
  end

  def search
    @orders = current_user.orders
    @orders = @orders.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @orders.search(params[:query])
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.full_creation(params[:order])
    authorize! :create, @order
    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.update(status: :canceled)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.expect(order: %i[customer_id store_id])
  end
end
