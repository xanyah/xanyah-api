# frozen_string_literal: true

require 'acceptance_helper'

resource 'VAT rates', document: :v2 do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :authorization

  let(:membership) { create(:store_membership, role: :admin) }
  let(:authorization) { "Bearer #{create(:access_token, resource_owner_id: membership.user_id).token}" }

  route '/v2/vat_rates', 'VAT rates' do
    get 'Returns all VAT rates' do
      parameter 'q[country_code_eq]', 'Filter by country'

      example_request 'List all VAT rates' do
        expect(response_status).to eq(200)
      end
    end
  end
end
