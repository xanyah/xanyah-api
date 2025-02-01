# frozen_string_literal: true

require 'acceptance_helper'

resource 'Orders', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/orders', 'Orders collection' do
    get 'Returns all orders' do
      example_request 'List all orders' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(0)
      end
    end

    post 'Create an order' do
      with_options scope: :order, with_example: true do
        parameter :store_id, "Orders's store id", required: true
        parameter :customer_id, "Orders's customer id", required: true
        parameter :order_products_attributes,
                  "Orders's products",
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      product_id: { type: :string },
                      quantity: { type: :integer },
                      amount_cents: { type: :integer },
                      amount_currency: { type: :string }
                    }
                  },
                  required: true
      end

      let(:store_id) { membership.store.id }
      let(:customer_id) { create(:customer, store: membership.store).id }
      let(:order_products_attributes) do
        Array.new(5).map do
          product = create(:product,
                           category: create(:category,
                                            store: membership.store),
                           store: membership.store)
          {
            product_id: product.id,
            quantity: rand(20)
          }
        end
      end

      example_request 'Create an order' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/v2/orders/:id', 'Single order' do
    let!(:order) { create(:order, store: membership.store) }

    get 'Get a specific order' do
      let(:id) { order.id }

      example_request 'Getting an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end
  end

  route '/v2/orders/:id/cancel', 'Single order' do
    let!(:order) { create(:order, store: membership.store, state: :ordered) }

    patch 'Cancel an order' do
      let(:id) { order.id }

      example_request 'Cancelling an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['state']).to eq('cancelled')
      end
    end
  end

  route '/v2/orders/:id/order', 'Single order' do
    let!(:order) { create(:order, store: membership.store) }

    patch 'Order an order' do
      let(:id) { order.id }

      example_request 'Ordering an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['state']).to eq('ordered')
      end
    end
  end

  route '/v2/orders/:id/deliver', 'Single order' do
    let!(:order) { create(:order, store: membership.store, state: :ordered) }

    patch 'Deliver an order' do
      let(:id) { order.id }

      example_request 'Delivering an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['state']).to eq('delivered')
      end
    end
  end

  route '/v2/orders/:id/withdraw', 'Single order' do
    let!(:order) { create(:order, store: membership.store, state: :delivered) }

    patch 'Withdraw an order' do
      let(:id) { order.id }

      example_request 'Withdrawing an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['state']).to eq('withdrawn')
      end
    end
  end
end
