# frozen_string_literal: true

class StockBackupVariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /stock_backup_variants
  def index
    @stock_backup_variants = current_user.stock_backup_variants
    if params[:stock_backup_id].present?
      @stock_backup_variants = @stock_backup_variants.where(stock_backup_id: params[:stock_backup_id])
    end

    render json: @stock_backup_variants
  end

  # GET /stock_backup_variants/1
  def show
    render json: @stock_backup_variant
  end
end
