# frozen_string_literal: true

require 'acceptance_helper'

resource 'VAT rates' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  route '/vat_rates', 'VAT rates' do
    get 'Returns all VAT rates' do
      example_request 'List all VAT rates' do
        expect(response_status).to eq(200)
      end
    end
  end

  route '/vat_rates/:country', 'Single VAT rate' do
    get 'Get VAT rates for a country' do
      let(:country) { 'ES' }

      example_request 'Getting VAT rates for a country' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['country_code']).to eq(country)
      end
    end
  end
end
