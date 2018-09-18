# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Variants', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /variants' do
    it 'returns only permitted variants' do
      create(:variant)
      create(:variant, product: create(:product, store: store))
      get variants_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return empty if !membership' do
      get variants_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get variants_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /variants/:id' do
    it 'returns variant if membership' do
      variant = create(:variant, product: create(:product, store: store))
      get variant_path(variant), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get variant_path(create(:variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get variant_path(create(:variant))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'PATCH /variants/:id' do
    it 'updates variant if membership' do
      store_membership.update(role: :admin)
      variant = create(:variant, product: create(:product, store: store))
      new_variant = build(:variant)
      patch variant_path(variant),
            params:  {variant: {ratio: new_variant.ratio}},
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['ratio']).to eq(new_variant.ratio)
    end

    it 'returns 401 if !membership' do
      new_variant = build(:variant)
      patch variant_path(create(:variant)),
            params:  {variant: {ratio: new_variant.ratio}},
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      new_variant = build(:variant)
      patch variant_path(create(:variant)), params: {variant: {ratio: new_variant.ratio}}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'DELETE /variants/:id' do
    it 'destroys variant if membership' do
      store_membership.update(role: :admin)
      variant = create(:variant, product: create(:product, store: store))
      delete variant_path(variant),
            headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete variant_path(create(:variant)),
            headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete variant_path(create(:variant))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
