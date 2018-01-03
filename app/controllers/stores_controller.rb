class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:show, :update, :destroy]

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
    @store = Store.new(store_create_params)

    if @store.save
      StoreMembership.create(user: current_user, store: @store)
      render json: @store, status: :created
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_update_params)
      render json: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = current_user.stores.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_create_params
      params.require(:store).permit(:name, :address, :country, :key)
    end

    def store_update_params
      params.require(:store).permit(:name, :address, :country)
    end
end
