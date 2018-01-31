class StockBackupVariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /stock_backup_variants
  def index
    @stock_backup_variants = current_user.stores.map {|s| s.stock_backup_variants }.flatten

    render json: @stock_backup_variants
  end

  # GET /stock_backup_variants/1
  def show
    render json: @stock_backup_variant
  end
end
