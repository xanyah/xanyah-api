# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InventoryVariants', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /inventory_variants' do
    it 'returns only permitted inventory_variants' do
      create(:inventory_variant)
      create(:inventory_variant,
             variant:   create(:variant, product: create(:product, store: store)),
             inventory: create(:inventory, store: store, locked_at: nil))
      get inventory_variants_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return empty if !membership' do
      get inventory_variants_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get inventory_variants_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /inventory_variants/:id' do
    it 'returns inventory_variant if membership' do
      inventory_variant = create(:inventory_variant,
                                 variant:   create(:variant, product: create(:product, store: store)),
                                 inventory: create(:inventory, store: store, locked_at: nil))
      get inventory_variant_path(inventory_variant), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get inventory_variant_path(create(:inventory_variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get inventory_variant_path(create(:inventory_variant))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'GET /inventory_variants/:inventory_id/:variant_id' do
    it 'returns inventory_variant if membership' do
      inventory_variant = create(:inventory_variant,
                                variant:  create(:variant, product: create(:product, store: store)),
                                inventory: create(:inventory, store: store, locked_at: nil))
      get "/inventory_variants/#{inventory_variant.inventory_id}/#{inventory_variant.variant_id}",
          headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      inventory_variant = create(:inventory_variant)
      get "/inventory_variants/#{inventory_variant.inventory_id}/#{inventory_variant.variant_id}",
          headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      inventory_variant = create(:inventory_variant)
      get "/inventory_variants/#{inventory_variant.inventory_id}/#{inventory_variant.variant_id}"
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /inventory_variants/:id' do
    it 'updates inventory_variant if membership' do
      store_membership.update(role: :admin)
      new_inventory_variant = build(:inventory_variant)
      inventory_variant = create(:inventory_variant,
                                 variant:   create(:variant, product: create(:product, store: store)),
                                 inventory: create(:inventory, store: store, locked_at: nil))
      patch inventory_variant_path(inventory_variant),
            params:  {inventory_variant: {quantity: new_inventory_variant.quantity}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['quantity']).not_to eq(12)
    end

    it 'returns 401 if !membership' do
      patch inventory_variant_path(create(:inventory_variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      patch inventory_variant_path(create(:inventory_variant))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    describe 'DELETE /inventory_variants/:id' do
      it 'deletes inventory variant if membership' do
        inventory_variant = create(:inventory_variant,
                                   variant:   create(:variant, product: create(:product, store: store)),
                                   inventory: create(:inventory, store: store, locked_at: nil))
        delete inventory_variant_path(inventory_variant), headers: store_membership.user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
      end

      it 'returns 401 if !membership' do
        delete inventory_variant_path(create(:inventory_variant)), headers: create(:user).create_new_auth_token
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('errors')
      end

      it 'returns 401 if !loggedin' do
        delete inventory_variant_path(create(:inventory_variant))
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end
