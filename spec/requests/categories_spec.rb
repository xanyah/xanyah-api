require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe "GET /categories" do
    it "returns only permitted categories" do
      create(:category)
      create(:category, store: store)
      get categories_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "return empty if !membership" do
      get categories_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get categories_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

   describe "GET /categories/:id" do
     it "returns category if membership" do
       category = create(:category, store: store)
       get category_path(category), headers: user.create_new_auth_token
       expect(response).to have_http_status(:ok)
       expect(JSON.parse(response.body)['id']).to be_present
     end

     it "returns 401 if !membership" do
       get category_path(create(:category)), headers: create(:user).create_new_auth_token
       expect(response).to have_http_status(:unauthorized)
     end

     it "returns 401 if !loggedin" do
       get category_path(create(:category))
       expect(response).to have_http_status(:unauthorized)
       expect(JSON.parse(response.body)).to have_key('errors')
     end
   end

   describe "PATCH /categories/:id" do
     it "updates category if membership" do
       store_membership.update(role: :admin)
       category = create(:category, store: store)
       new_category = build(:category)
       patch category_path(category), params: {category: {label: new_category.label} }, headers: user.create_new_auth_token
       expect(response).to have_http_status(:ok)
       expect(JSON.parse(response.body)['label']).to eq(new_category.label)
     end

     it "returns 401 if !membership" do
       new_category = build(:category)
       patch category_path(create(:category)), params: { category: {label: new_category.label} }, headers: create(:user).create_new_auth_token
       expect(response).to have_http_status(:unauthorized)
     end

     it "returns 401 if !loggedin" do
       new_category = build(:category)
       patch category_path(create(:category)), params: { category: {label: new_category.label} }
       expect(response).to have_http_status(:unauthorized)
       expect(JSON.parse(response.body)).to have_key('errors')
     end
   end
end
