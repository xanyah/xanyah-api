# frozen_string_literal: true

require 'acceptance_helper'

resource 'Providers', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/providers', 'Providers collection' do
    get 'Returns all providers' do
      parameter 'q[store_id_eq]', 'Filter by store'

      before do
        create(:provider)
        create(:provider, store: membership.store)
      end

      example_request 'List all providers' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a provider' do
      with_options scope: :provider, with_example: true do
        parameter :name, "Provider's name", required: true
        parameter :notes, 'Notes about provider'
        parameter :store_id, "Provider's store id", required: true
      end

      let(:name) { provider[:name] }
      let(:notes) { provider[:notes] }
      let(:store_id) { membership.store_id }
      let(:provider) { attributes_for(:provider) }

      example_request 'Create a provider' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/providers/:id', 'Single provider' do
    let!(:provider) { create(:provider, store: membership.store) }

    get 'Get a specific provider' do
      let(:id) { provider.id }

      example_request 'Getting a provider' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(provider.name)
      end
    end

    patch 'Update a specific provider' do
      with_options scope: :provider, with_example: true do
        parameter :name, "Provider's name"
        parameter :notes, 'Notes about provider'
      end

      let(:id) { provider.id }
      let(:name) { build(:provider).name }

      example_request 'Updating a provider' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Destroy a specific provider' do
      let(:id) { provider.id }

      example_request 'Destroying a provider' do
        expect(status).to eq(204)
      end
    end
  end
end
