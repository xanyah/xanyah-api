require 'rails_helper'

RSpec.describe "StockBackups", type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe "GET /stock_backups" do
    it "returns only permitted stock_backups" do
      create(:stock_backup)
      create(:stock_backup, store: store)
      get stock_backups_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "return empty if !membership" do
      get stock_backups_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get stock_backups_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /stock_backups/:id" do
    it "returns stock_backup if membership" do
      stock_backup = create(:stock_backup, store: store)
      get stock_backup_path(stock_backup), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it "returns 401 if !membership" do
      get stock_backup_path(create(:stock_backup)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      get stock_backup_path(create(:stock_backup))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
