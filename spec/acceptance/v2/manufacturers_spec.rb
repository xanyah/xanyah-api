# frozen_string_literal: true

require 'acceptance_helper'

resource 'Manufacturers', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/manufacturers', 'Manufacturers collection' do
    get 'Returns all manufacturers' do
      parameter 'q[store_id_eq]', 'Filter by store'
      parameter 'q[name_or_notes_cont]', 'Filter by name or notes'

      before do
        create(:manufacturer)
        create(:manufacturer, store: membership.store)
      end

      example_request 'List all manufacturers' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a manufacturer' do
      with_options scope: :manufacturer, with_example: true do
        parameter :name, "Manufacturer's name", required: true
        parameter :code, "Manufacturer's code (will be replaced by name's 4 first characters if empty)", required: true
        parameter :notes, 'Notes about manufacturer'
        parameter :store_id, "Manufacturer's store id", required: true
      end

      let(:name) { manufacturer[:name] }
      let(:notes) { manufacturer[:notes] }
      let(:store_id) { membership.store_id }
      let(:manufacturer) { attributes_for(:manufacturer) }

      example_request 'Create a manufacturer' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/manufacturers/:id', 'Single manufacturer' do
    let!(:manufacturer) { create(:manufacturer, store: membership.store) }

    get 'Get a specific manufacturer' do
      let(:id) { manufacturer.id }

      example_request 'Getting a manufacturer' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(manufacturer.name)
      end
    end

    patch 'Update a specific manufacturer' do
      with_options scope: :manufacturer, with_example: true do
        parameter :name, "Manufacturer's name"
        parameter :code, "Manufacturer's code (will be replaced by name's 4 first characters if empty)"
        parameter :notes, 'Notes about manufacturer'
      end

      let(:id) { manufacturer.id }
      let(:name) { build(:manufacturer).name }

      example_request 'Updating a manufacturer' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Destroy a specific manufacturer' do
      let(:id) { manufacturer.id }

      example_request 'Destroying a manufacturer' do
        expect(status).to eq(204)
      end
    end
  end
end
