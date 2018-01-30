class VariantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /variants
  def index
    @variants = current_user.stores.map {|s| s.products.map {|p| p.variants} }.flatten

    render json: @variants
  end

  # GET /variants/1
  def show
    render json: @variant
  end

  # POST /variants
  def create
    if @variant.save
      render json: @variant, status: :created, location: @variant
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /variants/1
  def update
    if @variant.update(update_params)
      render json: @variant
    else
      render json: @variant.errors, status: :unprocessable_entity
    end
  end

  private
  def create_params
    params.require(:variant).permit(:original_barcode, :buying_price, :tax_free_price, :provider_id, :product_id, :default, :ratio)
  end
  
  def update_params
    params.require(:variant).permit(:buying_price, :tax_free_price, :provider_id, :product_id, :default, :ratio)
  end
end
