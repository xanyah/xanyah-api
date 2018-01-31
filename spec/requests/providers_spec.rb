# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Providers', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /providers' do
    it 'returns only permitted providers' do
      create(:provider)
      create(:provider, store: store)
      get providers_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns empty if !membership' do
      get providers_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get providers_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /providers/:id' do
    it 'returns provider if membership' do
      provider = create(:provider, store: store)
      get provider_path(provider), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get provider_path(create(:provider)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get provider_path(create(:provider))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /providers/:id' do
    it 'updates provider if membership' do
      store_membership.update(role: :admin)
      provider = create(:provider, store: store)
      new_provider = build(:provider)
      patch provider_path(provider),
            params:  {provider: {name: new_provider.name}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(new_provider.name)
    end

    it 'returns 401 if !membership' do
      new_provider = build(:provider)
      patch provider_path(create(:provider)),
            params:  {provider: {name: new_provider.name}},
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_provider = build(:provider)
      patch provider_path(create(:provider)), params: {provider: {name: new_provider.name}}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
