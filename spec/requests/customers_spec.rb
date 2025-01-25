# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers' do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /customers' do
    it 'returns only permitted customers' do
      create(:customer)
      create(:customer, store: store)
      get customers_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'return empty if !membership' do
      get customers_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get customers_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /customers/:id' do
    it 'returns customer if membership' do
      customer = create(:customer, store: store)
      get customer_path(customer), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get customer_path(create(:customer)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get customer_path(create(:customer))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'PATCH /customers/:id' do
    it 'updates customer if membership' do
      store_membership.update(role: :admin)
      customer = create(:customer, store: store)
      new_customer = build(:customer)
      patch customer_path(customer),
            params: { customer: { firstname: new_customer.firstname } },
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['firstname']).to eq(new_customer.firstname)
    end

    it 'returns 401 if !membership' do
      new_customer = build(:customer)
      patch customer_path(create(:customer)),
            params: { customer: { firstname: new_customer.firstname } },
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_customer = build(:customer)
      patch customer_path(create(:customer)), params: { customer: { firstname: new_customer.firstname } }
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'DELETE /customers/:id' do
    it 'destroys customer if membership' do
      store_membership.update(role: :admin)
      customer = create(:customer, store: store)
      delete customer_path(customer),
             headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete customer_path(create(:customer)),
             headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete customer_path(create(:customer))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end
end
