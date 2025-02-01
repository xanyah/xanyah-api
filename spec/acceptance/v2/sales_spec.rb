# frozen_string_literal: true

require 'acceptance_helper'

resource 'Sales', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/sales', 'Sales collection' do
    get 'Returns all sales' do
      parameter 'q[store_id_eq]', 'Filter by store id'
      parameter 'q[product_id_eq]', 'Filter by product id'

      example_request 'List all sales' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(0)
      end
    end

    post 'Create a sale' do
      with_options scope: :sale do
        parameter :store_id, "Sales's store id", required: true
        parameter :customer_id, "Sales's customer id"
        parameter :total_price, "Sale's total", required: true

        parameter :sale_products_attributes,
                  "Sales's products",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      product_id: { type: :string },
                      quantity: { type: :integer },
                      sale_product_promotion_attributes: {
                        type: :object,
                        properties: {
                          type: { type: :string },
                          amount_cents: { type: :integer },
                          amount_currency: { type: :string }
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
                      total_amount_cents: { type: :integer },
                      total_amount_currency: { type: :string }
                    }
                  },
                  required: true

        parameter :sale_promotion_attributes,
                  'Promotion to apply on the sale',
                  type: :object,
                  properties: {
                    type: { type: :string },
                    amount_cents: { type: :integer },
                    amount_currency: { type: :string }
                  }
      end

      let(:store_id) { membership.store.id }
      let(:sale_products_attributes) do
        Array.new(5).map do
          product = create(:product, store: membership.store)
          {
            product_id: product.id,
            amount_cents: product.amount_cents,
            amount_currency: product.amount_currency,
            quantity: rand(20)
          }
        end
      end
      let(:total_price) { sale_products_attributes.inject(0) { |sum, element| sum + (element[:quantity] * element[:amount_cents]) } }
      let(:sale_payment_attributes) do
        vat = VatRate.find_by(country_code: membership.store.country)
        total = sale_products_attributes.sum do |v|
          v[:quantity].to_i * (v[:amount_cents] + (v[:amount_cents] * (vat.rate_percent_cents / 10_000)))
        end
        [{
          payment_type_id: create(:payment_type, store_id: store_id).id,
          total_amount_cents: total
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
