class StoreMembershipsController < ApplicationController
  before_action :set_store_membership, only: [:show, :update, :destroy]

  # GET /store_memberships
  def index
    @store_memberships = StoreMembership.all

    render json: @store_memberships
  end

  # GET /store_memberships/1
  def show
    render json: @store_membership
  end

  # POST /store_memberships
  def create
    @store_membership = StoreMembership.new(store_membership_params)

    if @store_membership.save
      render json: @store_membership, status: :created
    else
      render json: @store_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /store_memberships/1
  def update
    if @store_membership.update(store_membership_params)
      render json: @store_membership
    else
      render json: @store_membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /store_memberships/1
  def destroy
    @store_membership.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_membership
      @store_membership = StoreMembership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_membership_params
      params.require(:store_membership).permit(:store_id, :user_id, :role)
    end
end
