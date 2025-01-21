# frozen_string_literal: true

require 'acceptance_helper'

resource 'Categories', document: :v2 do
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

  route '/v2/categories', 'Categories collection' do
    get 'Returns all categories' do
      parameter 'q[store_id_eq]', 'Filter by store'

      before do
        create(:category)
        create(:category, store: membership.store)
      end

      example_request 'List all categories' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a category' do
      with_options scope: :category, with_example: true, required: true do
        parameter :name, "Category's name"
        parameter :vat_rate_id, "Category's TVA rate"
        parameter :store_id, "Category's store id"
      end

      let(:name) { category[:name] }
      let(:vat_rate_id) { VatRate.first.id }
      let(:store_id) { membership.store_id }
      let(:category) { attributes_for(:category) }

      example_request 'Create a category' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/categories/:id', 'Single category' do
    let!(:category) { create(:category, store: membership.store) }

    get 'Get a specific category' do
      let(:id) { category.id }

      example_request 'Getting a category' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(category.name)
      end
    end

    patch 'Update a specific category' do
      let(:id) { category.id }
      let(:name) { build(:category).name }

      with_options scope: :category, with_example: true do
        parameter :name, "Category's name"
        parameter :tva, "Category's TVA rate", type: :number
      end

      example_request 'Updating a category' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Destroy a specific category' do
      let(:id) { category.id }

      example_request 'Destroying a category' do
        expect(status).to eq(204)
      end
    end
  end
end
