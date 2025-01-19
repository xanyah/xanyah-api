# frozen_string_literal: true

require 'acceptance_helper'

resource 'Sales', document: :v2 do
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

  route '/v2/sales', 'Sales collection' do
    get 'Returns all sales' do
      parameter 'q[store_id_eq]', 'Filter by store id'
      parameter 'q[variant_id_eq]', 'Filter by variant id'

      example_request 'List all sales' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(0)
      end
    end

    post 'Create a sale' do
      with_options scope: :sale do
        parameter :store_id, "Sales's store id", required: true
        parameter :client_id, "Sales's client id"
        parameter :total_price, "Sale's total", required: true

        parameter :sale_variants_attributes,
                  "Sales's variants",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      variant_id: { type: :string },
                      quantity: { type: :integer },
                      sale_variant_promotion_attributes: {
                        type: :object,
                        properties: {
                          type: { type: :string },
                          amount: { type: :float }
                        }
                      }
                    }
                  },
                  required: true

        parameter :sale_payments_attributes,
                  "Sales's payments",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      payment_type_id: { type: :string },
                      total: { type: :float }
                    }
                  },
                  required: true

        parameter :sale_promotion_attributes,
                  'Promotion to apply on the sale',
                  type: :object,
                  properties: {
                    type: { type: :string },
                    amount: { type: :float }
                  }
      end

      let(:store_id) { membership.store.id }
      let(:sale_variants_attributes) do
        Array.new(5).map do
          variant = create(:variant, product: create(:product,
                                                     category: create(:category,
                                                                      tva: :standard_rate,
                                                                      store: membership.store),
                                                     store: membership.store))
          {
            variant_id: variant.id,
            unit_price: variant.price,
            quantity: rand(20)
          }
        end
      end
      let(:total_price) { sale_variants_attributes.inject(0) { |sum, element| sum + (element[:quantity] * element[:unit_price]) } }
      let(:sale_payment_attributes) do
        vat = VatRate.find_by(country_code: membership.store.country).standard_rate
        total = sale_variants_attributes.sum do |v|
          v[:quantity].to_i * (v[:unit_price].to_f + (v[:unit_price].to_f * (vat / 100)))
        end
        [{
          payment_type_id: create(:payment_type, store: membership.store).id,
          total: total
        }]
      end

      example_request 'Create a sale' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/sales/:id', 'Single sale' do
    let(:sale) { create(:sale, store: membership.store) }

    get 'Get a specific sale' do
      let(:id) { sale.id }

      example_request 'Getting a sale' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    delete 'Destroy a specific sale' do
      let(:id) { sale.id }

      example_request 'Destroying a sale' do
        expect(status).to eq(204)
      end
    end
  end
end
