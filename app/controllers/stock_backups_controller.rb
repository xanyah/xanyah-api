# frozen_string_literal: true

class StockBackupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /stock_backups
  def index
    @stock_backups = current_user.stores.map(&:stock_backups).flatten
    @stock_backups = @stock_backups.select {|c| c.store_id == params[:store_id] } if params[:store_id].present?

    render json: @stock_backups
  end

  # GET /stock_backups/1
  def show
    render json: @stock_backup
  end
end
