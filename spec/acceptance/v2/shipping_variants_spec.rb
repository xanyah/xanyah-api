# frozen_string_literal: true

require 'acceptance_helper'

resource 'Shipping Variants', document: :v2 do
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

  route '/v2/shipping_variants', 'Shipping variants collection' do
    get 'Returns all shipping_variants' do
      parameter 'q[shipping_id_eq]', 'Filter by shipping'

      before do
        create(:shipping_variant)
        create(:shipping_variant,
               variant: create(:variant, product: create(:product, store: membership.store)),
               shipping: create(:shipping, store: membership.store, locked_at: nil))
      end

      example_request 'List all shipping_variants' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create an shipping variant' do
      with_options scope: :shipping_variant, required: true, with_example: true do
        parameter :shipping_id, "Shipping variant's shipping id"
        parameter :variant_id, "Shipping variant's variant id"
        parameter :quantity, "Shipping variant's quantity", type: :number
      end

      let(:variant_id) { create(:variant, product: create(:product, store: membership.store)).id }
      let(:shipping_id) { create(:shipping, store: membership.store, locked_at: nil).id }
      let(:quantity) { 5 }

      example_request 'Create an shipping variant' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/shipping_variants/:id', 'Single shipping variant' do
    let!(:shipping_variant) do
      create(:shipping_variant,
             variant: create(:variant, product: create(:product, store: membership.store)),
             shipping: create(:shipping, store: membership.store, locked_at: nil))
    end

    get 'Get a specific shipping variant' do
      let(:id) { shipping_variant.id }

      example_request 'Getting an shipping variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    patch 'Update an specific shipping variant' do
      with_options scope: :shipping_variant, with_example: true do
        parameter :quantity, "Shipping variant's quantity"
      end

      let(:id) { shipping_variant.id }
      let(:quantity) { 12 }

      example_request 'Updating an shipping variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['quantity']).to eq(quantity)
      end
    end

    delete 'Delete a specific shipping variant' do
      let(:id) { shipping_variant.id }

      example_request 'Deleting an shipping variant' do
        expect(status).to eq(204)
        expect(response_body).to be_empty
      end
    end
  end
end
