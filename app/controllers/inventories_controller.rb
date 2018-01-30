class InventoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /inventories
  def index
    @inventories = current_user.stores.map {|s| s.inventories }.flatten

    render json: @inventories
  end

  # GET /inventories/1
  def show
    render json: @inventory
  end

  # POST /inventories
  def create
    if @inventory.save
      render json: @inventory, status: :created, location: @inventory
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  def lock
    if @inventory.update(locked_at: Time.now)
      render json: @inventory
    else
      render json: @inventory.errors, status: :unprocessable_entity
    end
  end

  private
    def create_params
      params.require(:inventory).permit(:store_id)
    end
end
