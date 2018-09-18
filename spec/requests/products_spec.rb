# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /products' do
    it 'returns only permitted products' do
      create(:product)
      create(:product, store: store)
      get products_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'filters by manufacturer' do
      p = create(:product, store: store)
      create(:product, store: store)
      get products_path(manufacturer_id: p.manufacturer_id), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq(1)
      expect(body[0]['id']).to eq(p.id)
    end

    it 'filters by provider' do
      v = create(:variant, product: create(:product, store: store))
      create(:variant, product: create(:product, store: store))
      get products_path(provider_id: v.provider_id), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq(1)
      expect(body[0]['id']).to eq(v.product.id)
    end

    it 'return empty if !membership' do
      get products_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get products_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /products/:id' do
    it 'returns product if membership' do
      product = create(:product, store: store)
      get product_path(product), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get product_path(create(:product)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get product_path(create(:product))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /products/:id' do
    it 'updates product if membership' do
      store_membership.update(role: :admin)
      product = create(:product, store: store)
      new_product = build(:product)
      patch product_path(product),
            params:  {product: {name: new_product.name}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(new_product.name)
    end

    it 'returns 401 if !membership' do
      new_product = build(:product)
      patch product_path(create(:product)),
            params:  {product: {name: new_product.name}},
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_product = build(:product)
      patch product_path(create(:product)), params: {product: {name: new_product.name}}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'DELETE /products/:id' do
    it 'destroy product if membership' do
      store_membership.update(role: :admin)
      product = create(:product, store: store)
      delete product_path(product),
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete product_path(create(:product)),
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete product_path(create(:product))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
