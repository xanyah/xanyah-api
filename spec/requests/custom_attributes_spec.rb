# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CustomAttributes', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /custom_attributes' do
    it 'returns only permitted custom_attributes' do
      create(:custom_attribute)
      create(:custom_attribute, store: store)
      get custom_attributes_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return empty if !membership' do
      get custom_attributes_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get custom_attributes_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /custom_attributes/:id' do
    it 'returns custom_attribute if membership' do
      custom_attribute = create(:custom_attribute, store: store)
      get custom_attribute_path(custom_attribute), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get custom_attribute_path(create(:custom_attribute)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get custom_attribute_path(create(:custom_attribute))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /custom_attributes/:id' do
    it 'updates custom_attribute if membership' do
      store_membership.update(role: :admin)
      custom_attribute = create(:custom_attribute, store: store)
      new_custom_attribute = build(:custom_attribute)
      patch custom_attribute_path(custom_attribute),
            params:  {custom_attribute: {name: new_custom_attribute.name}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(new_custom_attribute.name)
    end

    it 'returns 401 if !membership' do
      new_custom_attribute = build(:custom_attribute)
      patch custom_attribute_path(create(:custom_attribute)),
            params:  {custom_attribute: {name: new_custom_attribute.name}},
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_custom_attribute = build(:custom_attribute)
      patch custom_attribute_path(create(:custom_attribute)),
            params: {custom_attribute: {name: new_custom_attribute.name}}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
