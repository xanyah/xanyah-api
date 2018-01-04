require 'rails_helper'

RSpec.describe "StoreMemberships", type: :request do
  describe "GET /store_memberships" do
    it "returns only permitted memberships" do
      membership = create(:store_membership)
      create(:store_membership)
      get store_memberships_path, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "returns empty if !membership" do
      get store_memberships_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get store_memberships_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /store_memberships/:id" do
    it "returns store if membership" do
      membership = create(:store_membership)
      get store_membership_path(membership), headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to be_present
    end

    it "returns 401 if !membership" do
      get store_membership_path(create(:store_membership)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 401 if !loggedin" do
      get store_membership_path(create(:store_membership))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe "PATCH /store_memberships/:id" do
    it "updates membership if membership >= admin" do
      membership = create(:store_membership, role: :admin)
      new_membership = create(:store_membership, store: membership.store)
      patch store_membership_path(new_membership), params: { store_membership: {role: :regular} }, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['role']).to eq('regular')
    end

    it "returns 401 if membership < admin" do
      membership = create(:store_membership, role: :regular)
      new_membership = create(:store_membership, store: membership.store)
      patch store_membership_path(new_membership), params: { store_membership: {role: :regular} }, headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it "returns 401 if !membership" do
      patch store_membership_path(create(:store_membership)), params: { store_membership: {role: :regular} }, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it "returns 401 if !loggedin" do
      patch store_membership_path(create(:store_membership)), params: { store_membership: {role: :regular} }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe "DELETE /store_memberships/:id" do
    it "deletes membership if membership >= admin" do
      membership = create(:store_membership, role: :admin)
      new_membership = create(:store_membership, store: membership.store)
      delete store_membership_path(new_membership), headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it "returns 401 if membership < admin" do
      membership = create(:store_membership, role: :regular)
      new_membership = create(:store_membership, store: membership.store)
      delete store_membership_path(new_membership), headers: membership.user.create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it "returns 401 if !membership" do
      delete store_membership_path(create(:store_membership)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it "returns 401 if !loggedin" do
      delete store_membership_path(create(:store_membership))
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end
end
