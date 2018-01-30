require 'rails_helper'

RSpec.describe "Manufacturers", type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe "GET /manufacturers" do
    it "returns only permitted manufacturers" do
      create(:manufacturer)
      create(:manufacturer, store: store)
      get manufacturers_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "return empty if !membership" do
      get manufacturers_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get manufacturers_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

   describe "GET /manufacturers/:id" do
     it "returns manufacturer if membership" do
       manufacturer = create(:manufacturer, store: store)
       get manufacturer_path(manufacturer), headers: user.create_new_auth_token
       expect(response).to have_http_status(:ok)
       expect(JSON.parse(response.body)['id']).to be_present
     end

     it "returns 401 if !membership" do
       get manufacturer_path(create(:manufacturer)), headers: create(:user).create_new_auth_token
       expect(response).to have_http_status(:unauthorized)
     end

     it "returns 401 if !loggedin" do
       get manufacturer_path(create(:manufacturer))
       expect(response).to have_http_status(:unauthorized)
       expect(JSON.parse(response.body)).to have_key('errors')
     end
   end

   describe "PATCH /manufacturers/:id" do
     it "updates manufacturer if membership" do
       store_membership.update(role: :admin)
       manufacturer = create(:manufacturer, store: store)
       new_manufacturer = build(:manufacturer)
       patch manufacturer_path(manufacturer), params: {manufacturer: {name: new_manufacturer.name} }, headers: user.create_new_auth_token
       expect(response).to have_http_status(:ok)
       expect(JSON.parse(response.body)['name']).to eq(new_manufacturer.name)
     end

     it "returns 401 if !membership" do
       new_manufacturer = build(:manufacturer)
       patch manufacturer_path(create(:manufacturer)), params: { manufacturer: {name: new_manufacturer.name} }, headers: create(:user).create_new_auth_token
       expect(response).to have_http_status(:unauthorized)
     end

     it "returns 401 if !loggedin" do
       new_manufacturer = build(:manufacturer)
       patch manufacturer_path(create(:manufacturer)), params: { manufacturer: {name: new_manufacturer.name} }
       expect(response).to have_http_status(:unauthorized)
       expect(JSON.parse(response.body)).to have_key('errors')
     end
   end
end
