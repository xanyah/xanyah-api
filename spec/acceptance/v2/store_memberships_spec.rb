# frozen_string_literal: true

require 'acceptance_helper'

resource 'Store Memberships', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/store_memberships', 'Store memberships collection' do
    get 'Returns all store memberships' do
      parameter 'q[store_id_eq]', 'Filter by store'

      example_request 'List all store memberships' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    # post 'Create a store membership' do
    #   with_options scope: :store_membership, required: true, with_example: true do
    #     parameter :user_id, "Membership's user"
    #     parameter :store_id, "Membership's store"
    #     parameter :role, "Membership's role (regular, admin, owner)",
    #               type: :string,
    #               enum: %w[regular admin owner]
    #   end

    #   let(:user_id) { create(:user).id }
    #   let(:store_id) { membership.store.id }
    #   let(:role) { :regular }

    #   example_request 'Create a store membership' do
    #     expect(response_status).to eq(201)
    #     expect(JSON.parse(response_body)['id']).to be_present
    #   end
    # end
  end

  route '/v2/store_memberships/:id', 'Single store membership' do
    get 'Get a specific store membership' do
      let(:id) { create(:store_membership, store: membership.store).id }

      example_request 'Getting a store membership' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    patch 'Update a specific store membership' do
      parameter :role, "Membership's role (regular, admin, owner)",
                type: :string,
                enum: %w[regular admin owner],
                scope: :store_membership

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
