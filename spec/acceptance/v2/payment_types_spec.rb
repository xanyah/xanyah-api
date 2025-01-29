# frozen_string_literal: true

require 'acceptance_helper'

resource 'Payment Types', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/payment_types', 'PaymentTypes collection' do
    get 'Returns all payment_types' do
      parameter 'q[store_id_eq]', 'Filter by store'

      before do
        create(:payment_type)
        create(:payment_type, store: membership.store)
      end

      example_request 'List all payment_types' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a payment_type' do
      with_options scope: :payment_type, with_example: true do
        parameter :name, "PaymentType's name", required: true
        parameter :description, "PaymentType's description"
        parameter :store_id, "PaymentType's store id", required: true
      end

      let(:name) { payment_type[:name] }
      let(:description) { payment_type[:description] }
      let(:store_id) { membership.store_id }
      let(:payment_type) { attributes_for(:payment_type) }

      example_request 'Create a payment_type' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/payment_types/:id', 'Single payment_type' do
    let!(:payment_type) { create(:payment_type, store: membership.store) }

    get 'Get a specific payment_type' do
      let(:id) { payment_type.id }

      example_request 'Getting a payment_type' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(payment_type.name)
      end
    end

    patch 'Update a specific payment_type' do
      with_options scope: :payment_type, with_example: true do
        parameter :name, "PaymentType's name"
        parameter :description, "PaymentType's description"
      end

      let(:id) { payment_type.id }
      let(:name) { build(:payment_type).name }

      example_request 'Updating a payment_type' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Destroy a specific payment_type' do
      let(:id) { payment_type.id }

      example_request 'Destroying a payment_type' do
        expect(status).to eq(204)
      end
    end
  end
end
