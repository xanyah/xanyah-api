# frozen_string_literal: true

require 'acceptance_helper'

resource 'Inventories', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/inventories', 'Inventories collection' do
    get 'Returns all inventories' do
      parameter 'q[store_id_eq]', 'Filter by store'

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
      with_options scope: :inventory, required: true, with_example: true do
        parameter :store_id, "Inventory's store id"
      end

      let(:store_id) { membership.store_id }

      example_request 'Create a inventory' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/inventories/:id', 'Single inventory' do
    let!(:inventory) { create(:inventory, store: membership.store) }

    get 'Get a specific inventory' do
      let(:id) { inventory.id }

      example_request 'Getting a inventory' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    delete 'Delete a specific inventory' do
      let(:id) { inventory.id }

      example_request 'Deleting a inventory' do
        expect(status).to eq(204)
      end
    end
  end

  route '/v2/inventories/:id/lock', 'Single inventory' do
    let!(:inventory) { create(:inventory, store: membership.store, locked_at: nil) }

    patch 'Lock a specific inventory' do
      let(:id) { inventory.id }

      example_request 'Locking a inventory' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['locked_at']).not_to be_nil
      end
    end
  end
end
