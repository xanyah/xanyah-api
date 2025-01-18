# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /orders' do
    it 'returns only permitted orders' do
      create(:order)
      create(:order, store: store)
      get orders_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns empty if !membership' do
      get orders_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get orders_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /orders' do
    let(:order_variants) {
      Array.new(5).map do
        variant = create(:variant, product: create(:product,
                                                   category: create(:category,
                                                                    tva:   :standard_rate,
                                                                    store: store),
                                                   store:    store))
        {
          variant_id: variant.id,
          quantity:   rand(20)
        }
      end
    }
    let(:params) {
      {
        client_id:      create(:client, store: store).id,
        store_id:       store.id,
        order_variants: order_variants
      }
    }

    it 'creates only permitted orders' do
      post orders_path,
           params:  {order: params},
           headers: user.create_new_auth_token
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns empty if !membership' do
      post orders_path,
           params:  {order: params},
           headers: create(:user).create_new_auth_token
      expect(response).not_to have_http_status(:created)
    end

    it 'returns 401 if !loggedin' do
      post orders_path,
           params: {order: params}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /orders/:id' do
    it 'returns order if membership' do
      order = create(:order, store: store)
      get order_path(order), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get order_path(create(:order)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get order_path(create(:order))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'DELETE /orders/:id' do
    it 'destroys order if membership' do
      order = create(:order, store: store)
      delete order_path(order), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
    end

    it 'returns 401 if !membership' do
      delete order_path(create(:order)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete order_path(create(:order))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
