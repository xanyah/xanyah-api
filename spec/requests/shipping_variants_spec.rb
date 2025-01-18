# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShippingVariants' do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /shipping_variants' do
    it 'returns only permitted shipping_variants' do
      create(:shipping_variant)
      create(:shipping_variant,
             variant: create(:variant, product: create(:product, store: store)),
             shipping: create(:shipping, store: store, locked_at: nil))
      get shipping_variants_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'return empty if !membership' do
      get shipping_variants_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get shipping_variants_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /shipping_variants/:id' do
    it 'returns shipping_variant if membership' do
      shipping_variant = create(:shipping_variant,
                                variant: create(:variant, product: create(:product, store: store)),
                                shipping: create(:shipping, store: store, locked_at: nil))
      get shipping_variant_path(shipping_variant), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get shipping_variant_path(create(:shipping_variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get shipping_variant_path(create(:shipping_variant))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'GET /shipping_variants/:shipping_id/:variant_id' do
    it 'returns shipping_variant if membership' do
      shipping_variant = create(:shipping_variant,
                                variant: create(:variant, product: create(:product, store: store)),
                                shipping: create(:shipping, store: store, locked_at: nil))
      get "/shipping_variants/#{shipping_variant.shipping_id}/#{shipping_variant.variant_id}",
          headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      shipping_variant = create(:shipping_variant)
      get "/shipping_variants/#{shipping_variant.shipping_id}/#{shipping_variant.variant_id}",
          headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      shipping_variant = create(:shipping_variant)
      get "/shipping_variants/#{shipping_variant.shipping_id}/#{shipping_variant.variant_id}"
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'PATCH /shipping_variants/:id' do
    it 'updates shipping_variant if membership' do
      store_membership.update(role: :admin)
      new_shipping_variant = build(:shipping_variant)
      shipping_variant = create(:shipping_variant,
                                variant: create(:variant, product: create(:product, store: store)),
                                shipping: create(:shipping, store: store, locked_at: nil))
      patch shipping_variant_path(shipping_variant),
            params: { shipping_variant: { quantity: new_shipping_variant.quantity } },
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['quantity']).not_to eq(12)
    end

    it 'returns 401 if !membership' do
      patch shipping_variant_path(create(:shipping_variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      patch shipping_variant_path(create(:shipping_variant))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end

    describe 'DELETE /shipping_variants/:id' do
      it 'deletes shipping variant if membership' do
        shipping_variant = create(:shipping_variant,
                                  variant: create(:variant, product: create(:product, store: store)),
                                  shipping: create(:shipping, store: store, locked_at: nil))
        delete shipping_variant_path(shipping_variant), headers: store_membership.user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
      end

      it 'returns 401 if !membership' do
        delete shipping_variant_path(create(:shipping_variant)), headers: create(:user).create_new_auth_token
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body).to have_key('errors')
      end

      it 'returns 401 if !loggedin' do
        delete shipping_variant_path(create(:shipping_variant))
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body).to have_key('errors')
      end
    end
  end
end
