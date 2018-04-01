# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe InventoryVariantsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # InventoryVariant. As you add validations to InventoryVariant, be sure to
  # adjust the attributes here as well.
  let(:store_membership) { create(:store_membership, role: :admin) }
  let(:user) { store_membership.user }
  let(:valid_attributes) {
    attributes_for(:inventory_variant,
                   inventory_id: create(:inventory, store_id: store_membership.store_id, locked_at: nil).id,
                   variant_id:   create(:variant, product: create(:product,
                                                                  store_id:     store_membership.store_id,
                                                                  category:     create(
                                                                    :category,
                                                                    store: store_membership.store
                                                                  ),
                                                                  manufacturer: create(
                                                                    :manufacturer,
                                                                    store: store_membership.store
                                                                  ))).id)
  }
  let(:duplicate_valid_attributes) {
    store_membership = create(:store_membership, user: user)
    attributes_for(:inventory_variant,
                   inventory_id: create(:inventory, store_id: store_membership.store_id, locked_at: nil).id,
                   variant_id:   create(:variant, product: create(:product,
                                                                  store_id:     store_membership.store_id,
                                                                  category:     create(
                                                                    :category,
                                                                    store: store_membership.store
                                                                  ),
                                                                  manufacturer: create(
                                                                    :manufacturer,
                                                                    store: store_membership.store
                                                                  ))).id)
  }

  let(:invalid_attributes) {
    {
      quantity: -1
    }}

  describe 'GET #index' do
    it 'returns a success response' do
      InventoryVariant.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :index, params: {}
      expect(response).to be_success
    end

    it 'filters by inventory' do
      InventoryVariant.create! valid_attributes
      InventoryVariant.create! duplicate_valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :index, params: {inventory_id: valid_attributes[:inventory_id]}
      expect(response).to be_success
      expect(JSON.parse(response.body).size).to eq(1)
      get :index, params: {}
      expect(response).to be_success
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      inventory_variant = InventoryVariant.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :show, params: {id: inventory_variant.to_param}
      expect(response).to be_success
    end
  end

  describe 'GET #by_variant' do
    it 'returns a success response' do
      inventory_variant = InventoryVariant.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :by_variant, params: {inventory_id: inventory_variant.inventory_id, variant_id: inventory_variant.variant_id}
      expect(response).to be_success
    end

    it 'creates inventory variant if doesn\'t exist' do
      inventory_variant = InventoryVariant.new valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :by_variant, params: {inventory_id: inventory_variant.inventory_id, variant_id: inventory_variant.variant_id}
      expect(response).to be_success
      expect(InventoryVariant.where(
        inventory_id: inventory_variant.inventory_id,
        variant_id:   inventory_variant.variant_id
      ).size).to eq(1)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new InventoryVariant' do
        request.headers.merge! user.create_new_auth_token
        expect {
          post :create, params: {inventory_variant: valid_attributes}
        }.to change(InventoryVariant, :count).by(1)
      end

      it 'renders a JSON response with the new inventory_variant' do
        request.headers.merge! user.create_new_auth_token
        post :create, params: {inventory_variant: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(inventory_variant_url(InventoryVariant.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new inventory_variant' do
        request.headers.merge! user.create_new_auth_token
        post :create, params: {inventory_variant: invalid_attributes}
        expect(response).not_to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          quantity: 12
        }}

      it 'updates the requested inventory_variant' do
        inventory_variant = InventoryVariant.create! valid_attributes
        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: inventory_variant.to_param, inventory_variant: new_attributes}
        inventory_variant.reload
        expect(inventory_variant.quantity).to eq(12)
      end

      it 'renders a JSON response with the inventory_variant' do
        inventory_variant = InventoryVariant.create! valid_attributes

        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: inventory_variant.to_param, inventory_variant: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the inventory_variant' do
        inventory_variant = InventoryVariant.create! valid_attributes

        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: inventory_variant.to_param, inventory_variant: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested inventory_variant' do
      inventory_variant = InventoryVariant.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      expect {
        delete :destroy, params: {id: inventory_variant.to_param}
      }.to change(InventoryVariant, :count).by(-1)
    end
  end
end
