# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sales' do
  let(:store) { create(:store, country: 'fr') }
  let(:store_membership) { create(:store_membership, store: store) }
  let(:user) { store_membership.user }

  describe 'GET /sales' do
    it 'returns only permitted sales' do
      create(:sale)
      create(:sale, store: store)
      get sales_path, headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'filters by variant' do
      sale_variant = create(:sale_variant, sale: create(:sale, store: store))
      create(:sale_variant, sale: create(:sale, store: store))
      get sales_path(variant_id: sale_variant.variant_id), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end

    it 'returns empty if !membership' do
      get sales_path, headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(0)
    end

    it 'returns 401 if !loggedin' do
      get sales_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /sales' do
    let(:sale_variants) do
      Array.new(5).map do
        variant = create(:variant, product: create(:product,
                                                   category: create(:category,
                                                                    tva: :standard_rate,
                                                                    store: store),
                                                   store: store))
        {
          variant_id: variant.id,
          unit_price: variant.price,
          quantity: rand(20)
        }
      end
    end
    let(:sale_payments) do
      vat = VatRate.find_by(country_code: store.country).standard_rate
      total = sale_variants.sum do |v|
        v[:quantity].to_i * (v[:unit_price].to_f + (v[:unit_price].to_f * (vat / 100)))
      end
      [{
        payment_type_id: create(:payment_type, store: store).id,
        total: total
      }]
    end
    let(:params) do
      {
        store_id: store.id,
        sale_variants: sale_variants,
        sale_payments: sale_payments,
        sale_promotion: {
          type: 'flat_discount',
          amount: 20
        },
        total_price: sale_variants.inject(0) do |sum, element|
          sum + (element[:quantity] * element[:unit_price]) - 20
        end
      }
    end

    it 'creates only permitted sales' do
      post sales_path,
           params: { sale: params },
           headers: user.create_new_auth_token
      expect(response).to have_http_status(:created)
      expect(response.parsed_body['id']).to be_present
      expect(Sale.all.size).to eq(1)
      expect(SalePromotion.all.size).to eq(1)
      expect(SalePayment.all.size).to eq(1)
      expect(SaleVariant.all.size).to eq(5)
    end

    it 'returns empty if !membership' do
      post sales_path,
           params: { sale: params },
           headers: create(:user).create_new_auth_token
      expect(response).not_to have_http_status(:created)
    end

    it 'returns 401 if !loggedin' do
      post sales_path,
           params: { sale: params }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /sales/:id' do
    it 'returns sale if membership' do
      sale = create(:sale, store: store)
      get sale_path(sale), headers: user.create_new_auth_token
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    it 'returns 401 if !membership' do
      get sale_path(create(:sale)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      get sale_path(create(:sale))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end

  describe 'DELETE /sales/:id' do
    it 'destroys sale if membership' do
      sale = create(:sale, store: store)
      delete sale_path(sale), headers: user.create_new_auth_token
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 401 if !membership' do
      delete sale_path(create(:sale)), headers: create(:user).create_new_auth_token
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 if !loggedin' do
      delete sale_path(create(:sale))
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to have_key('errors')
    end
  end
end
