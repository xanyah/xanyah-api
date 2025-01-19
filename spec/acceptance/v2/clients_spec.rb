# frozen_string_literal: true

require 'acceptance_helper'

resource 'Clients', document: :v2 do
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

  route '/v2/clients', 'Clients collection' do
    get 'Returns all clients' do
      parameter 'q[store_id_eq]', 'Filter by store'
      parameter 'q[firstname_or_lastname_or_email_or_phone_cont]', 'Filter by firstname, lastname, email or phone'

      before do
        create(:client)
        create(:client, store: membership.store)
      end

      example_request 'List all clients' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a client' do
      with_options scope: :client, with_example: true do
        parameter :firstname, "Client's firstname"
        parameter :lastname, "Client's lastname"
        parameter :email, "Client's email"
        parameter :phone, "Client's phone"
        parameter :address, "Client's address"
        parameter :notes, "Client's notes"
        parameter :store_id, "Client's store id", required: true
      end

      let(:store_id) { membership.store_id }
      let(:firstname) { store_client[:firstname] }
      let(:lastname) { store_client[:lastname] }
      let(:email) { store_client[:email] }
      let(:phone) { store_client[:phone] }
      let(:address) { store_client[:address] }
      let(:notes) { store_client[:notes] }
      let(:store_client) { attributes_for(:client) }

      example_request 'Create a client' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/clients/:id', 'Single client' do
    let!(:store_client) { create(:client, store: membership.store) }

    get 'Get a specific client' do
      let(:id) { store_client.id }

      example_request 'Getting a client' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['firstname']).to eq(store_client.firstname)
      end
    end

    patch 'Update a specific client' do
      with_options scope: :client, with_example: true do
        parameter :firstname, "Client's firstname"
        parameter :lastname, "Client's lastname"
        parameter :email, "Client's email"
        parameter :phone, "Client's phone"
        parameter :address, "Client's address"
        parameter :notes, "Client's notes"
      end

      let(:id) { store_client.id }
      let(:firstname) { build(:client).firstname }

      example_request 'Updating a client' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['firstname']).to eq(firstname)
      end
    end

    delete 'Destroy a specific client' do
      let(:id) { store_client.id }

      example_request 'Destroying a client' do
        expect(status).to eq(204)
      end
    end
  end
end
