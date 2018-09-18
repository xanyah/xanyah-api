# frozen_string_literal: true

require 'acceptance_helper'

resource 'Sales' do
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

  route '/sales', 'Sales collection' do
    get 'Returns all sales' do
      parameter :store_id, 'Filter by store id'
      parameter :variant_id, 'Filter by variant id'

      example_request 'List all sales' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(0)
      end
    end

    post 'Create a sale' do
      with_options scope: :sale do
        parameter :store_id, "Sales's store id", required: true
        parameter :client_id, "Sales's client id"
        parameter :sale_variants,
                  "Sales's variants (array of sale variants: variant_id, quantity, unit_price, sale_variant_promotion)",
                  required: true
        parameter :sale_payments, "Sale's payments (array of sale payments: payment_type_id, total)", required: true
        parameter :total_price, "Sale's total", required: true
        parameter :sale_promotion, 'Promotion to apply on the sale'
      end

      let(:store_id) { membership.store.id }
      let(:sale_variants) {
        Array.new(5).map do
          variant = create(:variant, product: create(:product,
                                                     category: create(:category,
                                                                      tva:   :standard_rate,
                                                                      store: membership.store),
                                                     store:    membership.store))
          {
            variant_id: variant.id,
            unit_price: variant.price,
            quantity:   rand(20)
          }
        end
      }
      let(:total_price) { sale_variants.inject(0) {|sum, element| sum + (element[:quantity] * element[:unit_price]) } }
      let(:sale_payments) {
        vat = VatRate.find_by(country_code: membership.store.country).standard_rate
        total = sale_variants.map {|v|
          v[:quantity].to_i * (v[:unit_price].to_f + (v[:unit_price].to_f * (vat / 100)))
        }.inject :+
        [{
          payment_type_id: create(:payment_type, store: membership.store).id,
          total:           total
        }]
      }

      example_request 'Create a sale' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/sales/:id', 'Single sale' do
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
