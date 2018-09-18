# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clients', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /clients' do
    it 'returns only permitted clients' do
      create(:client)
      create(:client, store: store)
      get clients_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return empty if !membership' do
      get clients_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get clients_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /clients/:id' do
    it 'returns client if membership' do
      client = create(:client, store: store)
      get client_path(client), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get client_path(create(:client)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get client_path(create(:client))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /clients/:id' do
    it 'updates client if membership' do
      store_membership.update(role: :admin)
      client = create(:client, store: store)
      new_client = build(:client)
      patch client_path(client),
            params:  {client: {firstname: new_client.firstname}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['firstname']).to eq(new_client.firstname)
    end

    it 'returns 401 if !membership' do
      new_client = build(:client)
      patch client_path(create(:client)),
            params:  {client: {firstname: new_client.firstname}},
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_client = build(:client)
      patch client_path(create(:client)), params: {client: {firstname: new_client.firstname}}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'DELETE /clients/:id' do
    it 'destroys client if membership' do
      store_membership.update(role: :admin)
      client = create(:client, store: store)
      delete client_path(client),
             headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete client_path(create(:client)),
             headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete client_path(create(:client))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
