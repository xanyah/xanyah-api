# frozen_string_literal: true

require 'acceptance_helper'

resource 'Orders' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Access-Token', :access_token
  header 'Token-Type', :token_type
  header 'Client', :client_token
  header 'Expiry', :expiry
  header 'Uid', :uid

  let(:membership) { create(:store_membership, role: :admin) }
  let(:auth_token) { membership.user.create_new_auth_token }
  let(:access_token) { auth_token['access-token'] }
  let(:token_type) { auth_token['token-type'] }
  let(:client_token) { auth_token['client'] }
  let(:expiry) { auth_token['expiry'] }
  let(:uid) { auth_token['uid'] }

  route '/orders', 'Orders collection' do
    get 'Returns all orders' do
      example_request 'List all orders' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(0)
      end
    end

    post 'Create an order' do
      with_options scope: :order do
        parameter :store_id, "Orders's store id", required: true
        parameter :client_id, "Orders's client id", required: true
        parameter :order_variants,
                  "Orders's variants (array of order variants: variant_id, quantity, unit_price)",
                  required: true
      end

      let(:store_id) { membership.store.id }
      let(:client_id) { create(:client, store: membership.store).id }
      let(:order_variants) {
        Array.new(5).map do
          variant = create(:variant, product: create(:product,
                                                     category: create(:category,
                                                                      tva:   :standard_rate,
                                                                      store: membership.store),
                                                     store:    membership.store))
          {
            variant_id: variant.id,
            quantity:   rand(20)
          }
        end
      }

      example_request 'Create an order' do
        expect(response_status).to eq(201)
        expect(JSON.parse(response_body)['id']).to be_present
      end
    end
  end

  route '/orders/:id', 'Single order' do
    let!(:order) { create(:order, store: membership.store) }

    get 'Get a specific order' do
      let(:id) { order.id }

      example_request 'Getting an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end

    delete 'Cancel a specific order' do
      let(:id) { order.id }

      example_request 'Canceling an order' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
        expect(body['status']).to eq('canceled')
      end
    end
  end
end
