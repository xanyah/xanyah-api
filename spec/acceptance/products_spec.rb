require 'acceptance_helper'

resource 'Products' do
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

  route '/products', 'Products collection' do
    get 'Returns all products' do
      before do
        create(:product)
        create(:product, store: membership.store)
      end

      example_request "List all products" do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a product' do
      with_options scope: :product do
        parameter :name, "Product's name", required: true
        parameter :category_id, "Product's category id", required: true
        parameter :manufacturer_id, "Product's manufacturer id", required: true
        parameter :store_id, "Product's store id", required: true
      end

      let(:name) { product[:name] }
      let(:category_id) { create(:category, store: membership.store).id }
      let(:manufacturer_id) { create(:manufacturer, store: membership.store).id }
      let(:store_id) { membership.store_id }
      let(:product) { attributes_for(:product, store: membership.store) }

      example_request "Create a product" do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/products/:id', 'Single product' do
    let!(:product) { create(:product, store: membership.store) }

    with_options scope: :product do
      parameter :name, "Product's name", required: true
      parameter :category_id, "Product's category id", required: true
      parameter :manufacturer_id, "Product's manufacturer id", required: true
    end

    get 'Get a specific product' do
      let(:id) { product.id }

      example_request 'Getting a product' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(product.name)
      end
    end

    patch 'Update a specific product' do
      let(:id) { product.id }
      let(:name) { build(:product).name }

      example_request 'Updating a product' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end
  end
end
