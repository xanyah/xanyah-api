require 'rails_helper'

RSpec.describe "Inventories", type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe "GET /inventories" do
    it "returns only permitted inventories" do
      create(:inventory)
      create(:inventory, store: store)
      get inventories_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "return empty if !membership" do
      get inventories_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get inventories_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /inventories/:id" do
    it "returns inventory if membership" do
      inventory = create(:inventory, store: store)
      get inventory_path(inventory), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it "returns 401 if !membership" do
      get inventory_path(create(:inventory)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      get inventory_path(create(:inventory))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe "PATCH /inventories/:id/lock" do
    it "updates inventory if membership" do
      store_membership.update(role: :admin)
      inventory = create(:inventory, store: store, locked_at: nil)
      patch lock_inventory_path(inventory), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['locked_at']).not_to eq(nil)
    end

    it "returns 401 if !membership" do
      patch lock_inventory_path(create(:inventory)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      patch lock_inventory_path(create(:inventory))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
