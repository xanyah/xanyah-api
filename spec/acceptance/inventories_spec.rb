# frozen_string_literal: true

require 'acceptance_helper'

resource 'Inventories' do
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

  route '/inventories', 'Inventories collection' do
    get 'Returns all inventories' do
      before do
        create(:inventory)
        create(:inventory, store: membership.store)
      end

      example_request 'List all inventories' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a inventory' do
      with_options scope: :inventory do
        parameter :store_id, "Inventory's store id", required: true
      end

      let(:store_id) { membership.store_id }

      example_request 'Create a inventory' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/inventories/:id', 'Single inventory' do
    let!(:inventory) { create(:inventory, store: membership.store) }

    get 'Get a specific inventory' do
      let(:id) { inventory.id }

      example_request 'Getting a inventory' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end
  end

  route '/inventories/:id/lock', 'Single inventory' do
    let!(:inventory) { create(:inventory, store: membership.store, locked_at: nil) }

    patch 'Lock a specific inventory' do
      let(:id) { inventory.id }

      example_request 'Locking a inventory' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['locked_at']).not_to eq(nil)
      end
    end
  end
end
