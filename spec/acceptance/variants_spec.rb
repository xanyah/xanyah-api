# frozen_string_literal: true

require 'acceptance_helper'

resource 'Variants' do
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

  route '/variants', 'Variants collection' do
    get 'Returns all variants' do
      parameter :product_id, 'Filter by product'

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
      with_options scope: :variant do
        parameter :original_barcode, "Variant's original barcode", required: true
        parameter :buying_price, "Variant's buying price", required: true
        parameter :tax_free_price, "Variant's tax free price", required: true
        parameter :ratio, "Variant's ratio", required: true
        parameter :product_id, "Variant's product id", required: true
        parameter :provider_id, "Variant's provider id", required: true
        parameter :default, '(bool) Is it the product default variant ?', required: true
      end

      let(:original_barcode) { variant[:original_barcode] }
      let(:buying_price) { variant[:buying_price] }
      let(:tax_free_price) { variant[:tax_free_price] }
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

  route '/variants/:id', 'Single variant' do
    let!(:variant) { create(:variant, product: create(:product, store: membership.store)) }

    with_options scope: :variant do
      parameter :buying_price, "Variant's buying price", required: true
      parameter :tax_free_price, "Variant's tax free price", required: true
      parameter :ratio, "Variant's ratio", required: true
      parameter :default, '(bool) Is it the product default variant ?', required: true
    end

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
      let(:id) { variant.id }
      let(:ratio) { build(:variant).ratio }

      example_request 'Updating a variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['ratio']).to eq(ratio)
      end
    end
  end

  route '/variants/:id/by_barcode', 'Single variant' do
    let!(:variant) { create(:variant, product: create(:product, store: membership.store)) }

    get 'Get a specific variant' do
      let(:id) { variant.barcode }

      example_request 'Getting a variant by barcode' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(variant.id)
        expect(body['ratio']).to eq(variant.ratio)
      end
    end
  end

  route '/variants/search', 'Variants collection' do
    let!(:variant) { create(:variant, product: create(:product, name: 'Cacao', store: membership.store)) }

    parameter :store_id, 'Filter by store'
    parameter :product, 'Filter by product'
    parameter :query, 'Search query', required: true

    get 'Search variants' do
      let(:query) { 'Cacao' }

      example_request 'Searching variants' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body.size).to eq(1)
      end
    end
  end
end
