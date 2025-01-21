# frozen_string_literal: true

require 'acceptance_helper'

resource 'Variants', document: :v2 do
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

  route '/v2/variants', 'Variants collection' do
    get 'Returns all variants' do
      parameter 'q[product_id_eq]', 'Filter by product'
      parameter 'q[barcode_eq]', 'Filter by barcode'

      before do
        create(:variant)
        create(:variant, product: create(:product, store: membership.store))
      end

      example_request 'List all variants' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end

    post 'Create a variant' do
      with_options scope: :variant, required: true, with_example: true do
        parameter :original_barcode, "Variant's original barcode"
        parameter :buying_amount_cents, "Variant's buying price", type: :integer
        parameter :buying_amount_currency, "Variant's buying currency", type: :string
        parameter :tax_free_amount_cents, "Variant's tax free price", type: :integer
        parameter :tax_free_amount_currency, "Variant's tax free currency", type: :string
        parameter :ratio, "Variant's ratio", type: :float
        parameter :product_id, "Variant's product id"
        parameter :provider_id, "Variant's provider id"
        parameter :default, 'Is it the product default variant ?', type: :boolean
        parameter :variant_attributes_attributes,
                  "Variant's custom attributes",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      value: { type: :string },
                      custom_attribute_id: { type: :string }
                    }
                  }
      end

      let(:original_barcode) { variant[:original_barcode] }
      let(:buying_amount_cents) { variant[:buying_amount_cents] }
      let(:tax_free_amount_currency) { variant[:tax_free_amount_currency] }
      let(:buying_amount_cents) { variant[:buying_amount_cents] }
      let(:tax_free_amount_currency) { variant[:tax_free_amount_currency] }
      let(:ratio) { variant[:ratio] }
      let(:default) { variant[:default] }
      let(:provider_id) { create(:provider, store: membership.store).id }
      let(:product_id) { variant[:product_id] }
      let(:variant) { attributes_for(:variant, product_id: create(:product, store: membership.store).id) }

      example_request 'Create a variant' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/variants/:id', 'Single variant' do
    let!(:variant) { create(:variant, product: create(:product, store: membership.store)) }

    get 'Get a specific variant' do
      let(:id) { variant.id }

      example_request 'Getting a variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['ratio']).to eq(variant.ratio)
      end
    end

    patch 'Update a specific variant' do
      with_options scope: :variant, with_example: true do
        parameter :buying_amount_cents, "Variant's buying price", type: :integer
        parameter :buying_amount_currency, "Variant's buying currency", type: :string
        parameter :tax_free_amount_cents, "Variant's tax free price", type: :integer
        parameter :tax_free_amount_currency, "Variant's tax free currency", type: :string
        parameter :ratio, "Variant's ratio", type: :float
        parameter :default, 'Is it the product default variant ?', type: :boolean
        parameter :variant_attributes_attributes,
                  "Variant's custom attributes",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      destroy: { type: :boolean },
                      id: { type: :string },
                      value: { type: :string },
                      custom_attribute_id: { type: :string }
                    }
                  }
      end

      let(:id) { variant.id }
      let(:ratio) { build(:variant).ratio }

      example_request 'Updating a variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['ratio']).to eq(ratio)
      end
    end

    delete 'Destroy a specific variant' do
      let(:id) { variant.id }

      example_request 'Destroying a variant' do
        expect(status).to eq(204)
      end
    end
  end
end
