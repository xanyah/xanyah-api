# frozen_string_literal: true

require 'acceptance_helper'

resource 'VAT rates', document: :v2 do
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

  route '/v2/vat_rates', 'VAT rates' do
    get 'Returns all VAT rates' do
      parameter 'q[country_code_eq]', 'Filter by country'

      example_request 'List all VAT rates' do
        expect(response_status).to eq(200)
      end
    end
  end
end
