# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe ManufacturersController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Manufacturer. As you add validations to Manufacturer, be sure to
  # adjust the attributes here as well.
  let(:store_membership) { create(:store_membership) }
  let(:user) { store_membership.user }
  let(:valid_attributes) {
    attributes_for(:manufacturer, store_id: store_membership.store_id)
  }

  let(:invalid_attributes) {
    attributes_for(:manufacturer, store_id: store_membership.store_id, name: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ManufacturersController. Be sure to keep this updated too.

  describe 'GET #index' do
    it 'returns a success response' do
      Manufacturer.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      manufacturer = Manufacturer.create! valid_attributes
      request.headers.merge! user.create_new_auth_token
      get :show, params: {id: manufacturer.to_param}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Provider' do
        request.headers.merge! user.create_new_auth_token
        expect {
          post :create, params: {manufacturer: valid_attributes}
        }.to change(Manufacturer, :count).by(1)
      end

      it 'renders a JSON response with the new manufacturer' do
        request.headers.merge! user.create_new_auth_token
        post :create, params: {manufacturer: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new manufacturer' do
        request.headers.merge! user.create_new_auth_token
        post :create, params: {manufacturer: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          name: build(:manufacturer).name
        }}

      it 'updates the requested manufacturer' do
        manufacturer = Manufacturer.create! valid_attributes
        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: manufacturer.to_param, manufacturer: new_attributes}
        manufacturer.reload
        expect(manufacturer.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the manufacturer' do
        manufacturer = Manufacturer.create! valid_attributes
        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: manufacturer.to_param, manufacturer: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the manufacturer' do
        manufacturer = Manufacturer.create! valid_attributes
        request.headers.merge! user.create_new_auth_token
        put :update, params: {id: manufacturer.to_param, manufacturer: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
