# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shippings' do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /shippings' do
    it 'returns only permitted shippings' do
      create(:shipping)
      create(:shipping, store: store)
      get shippings_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'return empty if !membership' do
      get shippings_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get shippings_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /shippings/:id' do
    it 'returns shipping if membership' do
      shipping = create(:shipping, store: store)
      get shipping_path(shipping), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get shipping_path(create(:shipping)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get shipping_path(create(:shipping))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'PATCH /shippings/:id/lock' do
    it 'updates shipping if membership' do
      store_membership.update(role: :admin)
      shipping = create(:shipping, store: store, locked_at: nil)
      patch lock_shipping_path(shipping), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['locked_at']).not_to be_nil
    end

    it 'returns 401 if !membership' do
      patch lock_shipping_path(create(:shipping)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      patch lock_shipping_path(create(:shipping))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'DELETE /shippings/:id' do
    it 'deletes shipping product if membership >= admin' do
      store_membership.update(role: :admin)
      shipping = create(:shipping, store: store, locked_at: nil)
      delete shipping_path(shipping), headers: store_membership.user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if membership < admin' do
      store_membership.update(role: :regular)
      shipping = create(:shipping, store: store, locked_at: nil)
      delete shipping_path(shipping), headers: store_membership.user.create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if locked' do
      store_membership.update(role: :admin)
      shipping = create(:shipping, store: store, locked_at: nil)
      shipping.lock
      delete shipping_path(shipping), headers: store_membership.user.create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !membership' do
      delete shipping_path(create(:shipping)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end

    it 'returns 401 if !loggedin' do
      delete shipping_path(create(:shipping))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end
end
