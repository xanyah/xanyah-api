# frozen_string_literal: true

require 'acceptance_helper'

resource 'Inventory Variants' do
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

  route '/inventory_variants', 'Inventory variants collection' do
    get 'Returns all inventory_variants' do
      parameter :inventory_id, 'Filter by inventory'

      before do
        create(:inventory_variant)
        create(:inventory_variant,
               variant:   create(:variant, product: create(:product, store: membership.store)),
               inventory: create(:inventory, store: membership.store, locked_at: nil))
      end

      example_request 'List all inventory_variants' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create an inventory variant' do
      with_options scope: :inventory_variant do
        parameter :inventory_id, "Inventory variant's inventory id", required: true
        parameter :variant_id, "Inventory variant's variant id", required: true
        parameter :quantity, "Inventory variant's quantity", required: true
      end

      let(:variant_id) { create(:variant, product: create(:product, store: membership.store)).id }
      let(:inventory_id) { create(:inventory, store: membership.store, locked_at: nil).id }
      let(:quantity) { 5 }

      example_request 'Create an inventory variant' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/inventory_variants/:id', 'Single inventory variant' do
    let!(:inventory_variant) {
      create(:inventory_variant,
             variant:   create(:variant, product: create(:product, store: membership.store)),
             inventory: create(:inventory, store: membership.store, locked_at: nil))
    }

    with_options scope: :inventory_variant do
      parameter :quantity, "Inventory variant's quantity", required: true
    end

    get 'Get a specific inventory variant' do
      let(:id) { inventory_variant.id }

      example_request 'Getting an inventory variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    patch 'Update an specific inventory variant' do
      let(:id) { inventory_variant.id }
      let(:quantity) { 12 }

      example_request 'Updating an inventory variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['quantity']).to eq(quantity)
      end
    end

    delete 'Delete a specific inventory variant' do
      let(:id) { inventory_variant.id }

      example_request 'Deleting an inventory variant' do
        expect(status).to eq(204)
        expect(response_body).to be_empty
      end
    end
  end

  route '/inventory_variants/:inventory_id/:variant_id', 'Single inventory variant by inventory/variant id' do
    let!(:inventory_variant) {
      create(:inventory_variant,
             variant:  create(:variant, product: create(:product, store: membership.store)),
             inventory: create(:inventory, store: membership.store, locked_at: nil))
    }

    with_options scope: :inventory_variant do
      parameter :quantity, "Inventory variant's quantity", required: true
    end

    get 'Get a specific inventory variant by inventory and variant id' do
      let(:inventory_id) { inventory_variant.inventory_id }
      let(:variant_id) { inventory_variant.variant_id }

      example_request 'Getting an inventory variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(inventory_variant.id)
      end
    end
  end
end
