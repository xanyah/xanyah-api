# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VatRates', type: :request do
  describe 'GET /vat_rates' do
    it 'returns VAT rates' do
      get vat_rates_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /vat_rates/:country' do
    it 'returns VAT rate' do
      get vat_rate_path('ES')
      expect(response).to have_http_status(:ok)
    end
  end
end
