# frozen_string_literal: true

require 'acceptance_helper'

resource 'Stores', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :owner) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/stores', 'Stores collection' do
    get 'Returns all stores' do
      let!(:store) { create(:store) }

      example_request 'List all stores' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a store' do
      with_options scope: :store, with_example: true do
        parameter :name, "Store's name", required: true
        parameter :country_id, "Store's country", required: true
        parameter :key, "Store's key", required: true
        parameter :address1, "Store's address (line 1)"
        parameter :address2, "Store's address (line 2)"
        parameter :zipcode, "Store's zipcode"
        parameter :phone_number, "Store's phone number"
        parameter :website_url, "Store's website url"
        parameter :email_address, "Store's email address"
        parameter :color, "Store's color"
      end

      let(:name) { store[:name] }
      let(:address) { store[:address] }
      let(:country_id) { Country.first.id }
      let(:key) { store[:key] }
      let(:store) { attributes_for(:store) }

      example_request 'Create a store' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/stores/:id', 'Single store' do
    get 'Get a specific store' do
      let(:id) { membership.store.id }

      example_request 'Getting a store' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(membership.store.name)
        expect(body['store_membership']['id']).to eq(membership.id)
        expect(body['store_membership']['role']).to eq(membership.role)
      end
    end

    patch 'Update a specific store' do
      with_options scope: :store, with_example: true do
        parameter :name, "Store's name", required: true
        parameter :address, "Store's address"
        parameter :country, "Store's country", required: true
        parameter :address1, "Store's address (line 1)"
        parameter :address2, "Store's address (line 2)"
        parameter :zipcode, "Store's zipcode"
        parameter :phone_number, "Store's phone number"
        parameter :website_url, "Store's website url"
        parameter :email_address, "Store's email address"
        parameter :color, "Store's color"
      end

      let(:id) { membership.store.id }
      let(:name) { build(:store).name }

      example_request 'Updating a store' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Destroy a specific store' do
      let(:id) { membership.store.id }

      example_request 'Destroying a store' do
        expect(status).to eq(204)
      end
    end
  end
end
