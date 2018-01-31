# frozen_string_literal: true

require 'acceptance_helper'

resource 'Store Memberships' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Access-Token', :access_token
  header 'Token-Type', :token_type
  header 'Client', :client_id
  header 'Expiry', :expiry
  header 'Uid', :uid

  let(:membership) { create(:store_membership, role: :admin) }
  let(:auth_token) { membership.user.create_new_auth_token }
  let(:access_token) { auth_token['access-token'] }
  let(:token_type) { auth_token['token-type'] }
  let(:client_id) { auth_token['client'] }
  let(:expiry) { auth_token['expiry'] }
  let(:uid) { auth_token['uid'] }

  route '/store_memberships', 'Store memberships collection' do
    get 'Returns all store memberships' do
      example_request 'List all store memberships' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a store membership' do
      with_options scope: :store_membership do
        parameter :user_id, "Membership's user", required: true
        parameter :store_id, "Membership's store", required: true
        parameter :role, "Membership's role (regular, admin, owner)", required: true
      end

      let(:user_id) { create(:user).id }
      let(:store_id) { membership.store.id }
      let(:role) { :regular }

      example_request 'Create a store membership' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/store_memberships/:id', 'Single store membership' do
    parameter :role, "Membership's role (regular, admin, owner)", required: true, scope: :store_membership

    get 'Get a specific store membership' do
      let(:id) { create(:store_membership, store: membership.store).id }

      example_request 'Getting a store membership' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    patch 'Update a specific store membership' do
      let(:id) { create(:store_membership, role: :admin, store: membership.store).id }
      let(:role) { :admin }

      example_request 'Updating a store membership' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['role']).to eq('admin')
      end
    end

    delete 'Delete a specific store membership' do
      let(:id) { create(:store_membership, role: :regular, store: membership.store).id }

      example_request 'Deleting a store membership' do
        expect(status).to eq(204)
        expect(response_body).to eq('')
      end
    end
  end
end
