# frozen_string_literal: true

require 'acceptance_helper'

resource 'Custom Attributes', document: :v2 do
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

  route '/v2/custom_attributes', 'Custom Attributes collection' do
    get 'Returns all custom_attributes' do
      parameter 'q[store_id_eq]', 'Filter by store'

      before do
        create(:custom_attribute)
        create(:custom_attribute, store: membership.store)
      end

      example_request 'List all custom attributes' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a custom attribute' do
      with_options scope: :custom_attribute, with_example: true, required: true do
        parameter :name, "Custom Attribute's name"
        parameter :type, "Custom Attribute's type (text, number)"
        parameter :store_id, "Custom Attribute's store id"
      end

      let(:name) { custom_attribute[:name] }
      let(:type) { custom_attribute[:type] }
      let(:store_id) { membership.store_id }
      let(:custom_attribute) { attributes_for(:custom_attribute) }

      example_request 'Create a custom attribute' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/custom_attributes/:id', 'Single custom attribute' do
    let!(:custom_attribute) { create(:custom_attribute, store: membership.store) }

    get 'Get a specific custom attribute' do
      let(:id) { custom_attribute.id }

      example_request 'Getting a custom attribute' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(custom_attribute.name)
      end
    end

    patch 'Update a specific custom attribute' do
      with_options scope: :custom_attribute, with_example: true do
        parameter :name, "Custom Attribute's name"
        parameter :type, "Custom Attribute's type"
      end

      let(:id) { custom_attribute.id }
      let(:name) { build(:custom_attribute).name }

      example_request 'Updating a custom_attribute' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['name']).to eq(name)
      end
    end

    delete 'Delete a specific custom attribute' do
      let(:id) { custom_attribute.id }

      example_request 'Deleting a custom attribute' do
        expect(status).to eq(204)
        expect(CustomAttribute.where(id: id).count).to eq(0)
      end
    end
  end
end
