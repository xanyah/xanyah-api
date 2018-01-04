require 'rails_helper'

RSpec.describe "Stores", type: :request do

  describe "GET /stores" do
    it "returns only permitted stores" do
      membership = create(:store_membership)
      create(:store)
      get stores_path, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "returns empty if !membership" do
      get stores_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get stores_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /stores/:id" do
    it "returns store if membership" do
      membership = create(:store_membership)
      get store_path(membership.store), headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it "returns 401 if !membership" do
      get store_path(create(:store)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      get store_path(create(:store))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe "PATCH /stores/:id" do
    it "updates store if membership >= admin" do
      membership = create(:store_membership, role: :admin)
      new_store = build(:store)
      patch store_path(membership.store), params: { store: {name: new_store.name} }, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(new_store.name)
    end

    it "returns 401 if membership < admin" do
      membership = create(:store_membership, role: :regular)
      new_store = build(:store)
      patch store_path(membership.store), params: { store: {name: new_store.name} }, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it "returns 401 if !membership" do
      new_store = build(:store)
      patch store_path(create(:store)), params: { store: {name: new_store.name} }, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      new_store = build(:store)
      patch store_path(create(:store)), params: { store: {name: new_store.name} }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
