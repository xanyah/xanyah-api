# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories' do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /payment_types' do
    it 'returns only permitted payment_types' do
      create(:payment_type)
      create(:payment_type, store: store)
      get payment_types_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'return empty if !membership' do
      get payment_types_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get payment_types_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /payment_types/:id' do
    it 'returns payment_type if membership' do
      payment_type = create(:payment_type, store: store)
      get payment_type_path(payment_type), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get payment_type_path(create(:payment_type)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get payment_type_path(create(:payment_type))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'PATCH /payment_types/:id' do
    it 'updates payment_type if membership' do
      store_membership.update(role: :admin)
      payment_type = create(:payment_type, store: store)
      new_payment_type = build(:payment_type)
      patch payment_type_path(payment_type),
            params: { payment_type: { name: new_payment_type.name } },
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['name']).to eq(new_payment_type.name)
    end

    it 'returns 401 if !membership' do
      new_payment_type = build(:payment_type)
      patch payment_type_path(create(:payment_type)),
            params: { payment_type: { name: new_payment_type.name } },
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_payment_type = build(:payment_type)
      patch payment_type_path(create(:payment_type)), params: { payment_type: { name: new_payment_type.name } }
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'DELETE /payment_types/:id' do
    it 'destroys payment_type if membership' do
      store_membership.update(role: :admin)
      payment_type = create(:payment_type, store: store)
      delete payment_type_path(payment_type),
             headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete payment_type_path(create(:payment_type)),
             headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete payment_type_path(create(:payment_type))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end
end
