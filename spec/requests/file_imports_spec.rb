# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'File Imports', type: :request do
  let(:store_membership) { create(:store_membership) }
  let(:store) { store_membership.store }
  let(:user) { store_membership.user }

  describe 'POST /file_imports' do
    it 'Creates csv import if membership' do
      store_membership.update(role: :admin)
      expect {
        post file_imports_path,
             params:  {
               store_id: store.id,
               file:     fixture_file_upload('files/variants.csv', 'text/csv')
             },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
      }.to change(FileImportWorker.jobs, :size).by(1)
    end

    it 'Creates json import if membership' do
      store_membership.update(role: :admin)
      expect {
        post file_imports_path,
             params:  {
               store_id: store.id,
               file:     fixture_file_upload('files/variants.json', 'application/json')
             },
             headers: user.create_new_auth_token
        expect(response).to have_http_status(:no_content)
      }.to change(FileImportWorker.jobs, :size).by(1)
    end

    it 'returns 401 if !membership' do
      expect {
        post file_imports_path,
             params:  {
               store_id: store.id,
               file:     fixture_file_upload('files/variants.json', 'text/json')
             },
             headers: create(:user).create_new_auth_token
        expect(response).to have_http_status(:unauthorized)
      }.to change(FileImportWorker.jobs, :size).by(0)
    end

    it 'returns 401 if !loggedin' do
      expect {
        post file_imports_path,
             params: {
               store_id: store.id,
               file:     fixture_file_upload('files/variants.json', 'text/json')
             }
        expect(response).to have_http_status(:unauthorized)
      }.to change(FileImportWorker.jobs, :size).by(0)
    end
  end
end
