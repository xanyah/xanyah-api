# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StockBackupVariants' do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'GET /stock_backup_variants' do
    it 'returns only permitted stock_backup_variants' do
      create(:stock_backup_variant)
      create(:stock_backup_variant, stock_backup: create(:stock_backup, store: store))
      get stock_backup_variants_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'return empty if !membership' do
      get stock_backup_variants_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get stock_backup_variants_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /stock_backup_variants/:id' do
    it 'returns stock_backup_variant if membership' do
      stock_backup_variant = create(:stock_backup_variant, stock_backup: create(:stock_backup, store: store))
      get stock_backup_variant_path(stock_backup_variant), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get stock_backup_variant_path(create(:stock_backup_variant)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get stock_backup_variant_path(create(:stock_backup_variant))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end
end
