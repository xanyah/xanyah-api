require 'acceptance_helper' 

resource 'Stores' do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  header "Access-Token", :access_token
  header "Token-Type", :token_type
  header "Client", :client_id
  header "Expiry", :expiry
  header "Uid", :uid

  let(:membership) { create(:store_membership, role: :admin) }
  let(:auth_token) { membership.user.create_new_auth_token }
  let(:access_token) { auth_token['access-token'] }
  let(:token_type) { auth_token['token-type'] }
  let(:client_id) { auth_token['client'] }
  let(:expiry) { auth_token['expiry'] }
  let(:uid) { auth_token['uid'] }

  route '/stores', 'Stores collection' do
    get 'Returns all stores' do
      let!(:store) { create(:store) }
      example_request "List all stores" do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a store' do
      with_options scope: :store do
        parameter :name, "Store's name", required: true
        parameter :address, "Store's address"
        parameter :country, "Store's country", required: true
        parameter :key, "Store's key", required: true
      end

      let(:name) { store[:name] }
      let(:address) { store[:address] }
      let(:country) { store[:country] }
      let(:key) { store[:key] }
      let(:store) { attributes_for(:store) }

      example_request "Create a store" do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/stores/:id', 'Single store' do
    with_options scope: :store do
      parameter :name, "Store's name", required: true
      parameter :address, "Store's address"
      parameter :country, "Store's country", required: true
    end

    get 'Get a specific store' do
      let(:id) { membership.store.id }

      example_request 'Getting a store' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(membership.store.name)
      end
    end

    patch 'Update a specific store' do
      let(:id) { membership.store.id }
      let(:name) { build(:store).name }

      example_request 'Updating a store' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end
  end
end
