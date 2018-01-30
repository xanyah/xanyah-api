require 'rails_helper'

RSpec.describe "VariantAttributes", type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe "GET /variant_attributes" do
    it "returns only permitted variant_attributes" do
      create(:variant_attribute)
      create(:variant_attribute, variant: create(:variant, product: create(:product, store: store)))
      get variant_attributes_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "return empty if !membership" do
      get variant_attributes_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(0)
    end

    it "returns 401 if !loggedin" do
      get variant_attributes_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

    describe "GET /variant_attributes/:id" do
      it "returns variant_attribute if membership" do
        variant_attribute = create(:variant_attribute, variant: create(:variant, product: create(:product, store: store)))
        get variant_attribute_path(variant_attribute), headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to be_present
      end

      it "returns 401 if !membership" do
        get variant_attribute_path(create(:variant_attribute)), headers: create(:user).create_new_auth_token
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns 401 if !loggedin" do
        get variant_attribute_path(create(:variant_attribute))
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end

    describe "PATCH /variant_attributes/:id" do
      it "updates variant_attribute if membership" do
        store_membership.update(role: :admin)
        variant_attribute = create(:variant_attribute, variant: create(:variant, product: create(:product, store: store)))
        new_variant_attribute = build(:variant_attribute)
        patch variant_attribute_path(variant_attribute), params: {variant_attribute: {value: new_variant_attribute.value} }, headers: user.create_new_auth_token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['value']).to eq(new_variant_attribute.value)
      end

      it "returns 401 if !membership" do
        new_variant_attribute = build(:variant_attribute)
        patch variant_attribute_path(create(:variant_attribute)), params: { variant_attribute: {value: new_variant_attribute.value} }, headers: create(:user).create_new_auth_token
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns 401 if !loggedin" do
        new_variant_attribute = build(:variant_attribute)
        patch variant_attribute_path(create(:variant_attribute)), params: { variant_attribute: {value: new_variant_attribute.value} }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
end
