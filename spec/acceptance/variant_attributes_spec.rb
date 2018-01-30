require 'acceptance_helper'

resource 'Variant Attributes' do
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

  route '/variant_attributes', 'Variant Attributes collection' do
    get 'Returns all variant_attributes' do
      before do
        create(:variant_attribute)
        create(:variant_attribute, variant: create(:variant, product: create(:product, store: membership.store)))
      end

      example_request "List all variant attributes" do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a variant attribute' do
      with_options scope: :variant_attribute do
        parameter :value, "Variant Attribute's value", required: true
        parameter :custom_attribute_id, "Variant Attribute's custom attribute id", required: true
        parameter :variant_id, "Variant Attribute's variant id", required: true
      end

      let(:value) { variant_attribute[:value] }
      let(:custom_attribute_id) { variant_attribute[:custom_attribute_id] }
      let(:variant_id) { variant_attribute[:variant_id] }
      let(:variant_attribute) {
        attributes_for(:variant_attribute,
          custom_attribute_id: create(:custom_attribute, store: membership.store).id,
          variant_id: create(:variant, product: create(:product, store: membership.store)).id
        )
      }

      example_request "Create a variant attribute" do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/variant_attributes/:id', 'Single variant attribute' do
    let!(:variant_attribute) {
      create(:variant_attribute, variant: create(:variant, product: create(:product, store: membership.store)))
    }

    with_options scope: :variant_attribute do
      parameter :value, "Variant Attribute's value", required: true
    end

    get 'Get a specific variant attribute' do
      let(:id) { variant_attribute.id }

      example_request 'Getting a variant attribute' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['value']).to eq(variant_attribute.value)
      end
    end

    patch 'Update a specific variant attribute' do
      let(:id) { variant_attribute.id }
      let(:value) { build(:variant_attribute).value }

      example_request 'Updating a variant_attribute' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['value']).to eq(value)
      end
    end

    delete 'Delete a specific variant attribute' do
      let(:id) { variant_attribute.id }

      example_request 'Deleting a variant attribute' do
        expect(status).to eq(204)
        expect(VariantAttribute.where(id: id).size).to eq(0)
      end
    end
  end
end
