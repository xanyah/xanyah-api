require 'acceptance_helper'

resource 'Stock Backup Variants' do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  header "Access-Token", :access_token
  header "Token-Type", :token_type
  header "Client", :client_id
  header "Expiry", :expiry
  header "Uid", :uid

  let(:membership) { create(:store_membership, role: :admin) }
  let(:auth_token) { membership.user.create_new_auth_token }
  let(:access_token) { auth_token['access-token'] }
  let(:token_type) { auth_token['token-type'] }
  let(:client_id) { auth_token['client'] }
  let(:expiry) { auth_token['expiry'] }
  let(:uid) { auth_token['uid'] }

  route '/stock_backup_variants', 'Stock backup variants collection' do
    get 'Returns all stock backup_variants' do
      before do
        create(:stock_backup_variant)
        create(:stock_backup_variant, stock_backup: create(:stock_backup, store: membership.store))
      end

      example_request "List all stock backup_variants" do
        expect(response_status).to eq(200)
        expect(JSON.parse(response_body).size).to eq(1)
      end
    end
  end

  route '/stock_backup_variants/:id', 'Single stock backup variant' do
    let!(:stock_backup_variant) { create(:stock_backup_variant, stock_backup: create(:stock_backup, store: membership.store)) }

    get 'Get a specific stock backup variant' do
      let(:id) { stock_backup_variant.id }

      example_request 'Getting a stock backup variant' do
        expect(status).to eq(200)
        body = JSON.parse(response_body)
        expect(body['id']).to eq(id)
      end
    end
  end
end
