class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  # GET /stores
  def index
    @stores = Store.all

    render json: @stores
  end

  # GET /stores/1
  def show
    render json: @store
  end

  # POST /stores
  def create
    @store = Store.new(store_params)

    if @store.save
      render json: @store, status: :created, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stores/1
  def update
    if @store.update(store_params)
      render json: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stores/1
  def destroy
    @store.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_params
      params.require(:store).permit(:name, :address, :country, :key)
    end
end
