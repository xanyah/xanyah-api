# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: :show

  # GET /sales
  def index
    @sales = current_user.sales
    @sales = @sales.where(store_id: params[:store_id]) if params[:store_id].present?
    if params[:variant_id].present?
      @sales = @sales.joins(:variants)
      @sales = @sales.where(variants: {id: params[:variant_id]})
    end

    render json: @sales
  end

  # GET /sales/1
  def show
    render json: @sale
  end

  # POST /sales
  def create
    @sale = Sale.full_creation(params[:sale], current_user)
    authorize! :create, @sale
    if @sale.save
      render json: @sale, status: :created
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end
end
