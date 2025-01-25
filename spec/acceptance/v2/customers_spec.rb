# frozen_string_literal: true

require 'acceptance_helper'

resource 'Customer', document: :v2 do
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

  route '/v2/customers', 'Customers collection' do
    get 'Returns all customers' do
      parameter 'q[store_id_eq]', 'Filter by store'
      parameter 'q[firstname_or_lastname_or_email_or_phone_cont]', 'Filter by firstname, lastname, email or phone'

      before do
        create(:customer)
        create(:customer, store: membership.store)
      end

      example_request 'List all customers' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a customer' do
      with_options scope: :customer, with_example: true do
        parameter :firstname, "Customer's firstname"
        parameter :lastname, "Customer's lastname"
        parameter :email, "Customer's email"
        parameter :phone, "Customer's phone"
        parameter :address, "Customer's address"
        parameter :notes, "Customer's notes"
        parameter :store_id, "Customer's store id", required: true
      end

      let(:store_id) { membership.store_id }
      let(:firstname) { store_customer[:firstname] }
      let(:lastname) { store_customer[:lastname] }
      let(:email) { store_customer[:email] }
      let(:phone) { store_customer[:phone] }
      let(:address) { store_customer[:address] }
      let(:notes) { store_customer[:notes] }
      let(:store_customer) { attributes_for(:customer) }

      example_request 'Create a customer' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/customers/:id', 'Single customer' do
    let!(:store_customer) { create(:customer, store: membership.store) }

    get 'Get a specific customer' do
      let(:id) { store_customer.id }

      example_request 'Getting a customer' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['firstname']).to eq(store_customer.firstname)
      end
    end

    patch 'Update a specific customer' do
      with_options scope: :customer, with_example: true do
        parameter :firstname, "Customer's firstname"
        parameter :lastname, "Customer's lastname"
        parameter :email, "Customer's email"
        parameter :phone, "Customer's phone"
        parameter :address, "Customer's address"
        parameter :notes, "Customer's notes"
      end

      let(:id) { store_customer.id }
      let(:firstname) { build(:customer).firstname }

      example_request 'Updating a customer' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['firstname']).to eq(firstname)
      end
    end

    delete 'Destroy a specific customer' do
      let(:id) { store_customer.id }

      example_request 'Destroying a customer' do
        expect(status).to eq(204)
      end
    end
  end
end
