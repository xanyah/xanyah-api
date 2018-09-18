# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /categories
  def index
    @categories = current_user.categories
    @categories = @categories.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(update_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.require(:category).permit(:name, :tva, :store_id, :category_id)
  end

  def update_params
    params.require(:category).permit(:name, :category_id)
  end
end
