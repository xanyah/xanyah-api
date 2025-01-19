# frozen_string_literal: true

require 'acceptance_helper'

resource 'Stock Backups' do
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

  route '/stock_backups', 'Stock backups collection' do
    get 'Returns all stock backups' do
      parameter :store_id, 'Filter by store'

      before do
        create(:stock_backup)
        create(:stock_backup, store: membership.store)
      end

      example_request 'List all stock backups' do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end
  end

  route '/stock_backups/:id', 'Single stock_backup' do
    let!(:stock_backup) { create(:stock_backup, store: membership.store) }

    get 'Get a specific stock backup' do
      let(:id) { stock_backup.id }

      example_request 'Getting a stock_backup' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end
  end
end
