# frozen_string_literal: true

class StoreMembershipsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /store_memberships
  def index
    @store_memberships = current_user.stores_store_memberships
    @store_memberships = @store_memberships.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: @store_memberships
  end

  # GET /store_memberships/1
  def show
    render json: @store_membership
  end

  # POST /store_memberships
  def create
    if @store_membership.save
      render json: @store_membership, status: :created
    else
      render json: @store_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /store_memberships/1
  def update
    if @store_membership.update(update_params)
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

  # Only allow a trusted parameter "white list" through.
  def create_params
    params.expect(store_membership: %i[store_id user_id role])
  end

  def update_params
    params.expect(store_membership: [:role])
  end
end
