# frozen_string_literal: true

require 'rails_helper'
RSpec.describe FileImportWorker, type: :worker do
  describe 'formats' do
    it :csv do
      file = File.open Rails.root.join('spec', 'fixtures', 'files', 'variants.csv')
      membership = create(:store_membership, role: :admin)

      file_import = FileImport.create(user: membership.user, store: membership.store)
      file_import.file.attach io: file, filename: 'variants.csv', content_type: 'text/csv'

      expect(file_import.processed).to eq(false)
      FileImportWorker.new.perform file_import.id
      expect(Variant.all.size).to eq(1)
      expect(Product.all.size).to eq(1)

      file_import.reload
      expect(file_import.processed).to eq(true)
    end

    it :json do
      file = File.open Rails.root.join('spec', 'fixtures', 'files', 'variants.json')
      membership = create(:store_membership, role: :admin)

      file_import = FileImport.create(user: membership.user, store: membership.store)
      file_import.file.attach io: file, filename: 'variants.json', content_type: 'application/json'

      expect(file_import.processed).to eq(false)
      FileImportWorker.new.perform file_import.id
      expect(Variant.all.size).to eq(1)
      expect(Product.all.size).to eq(1)

      file_import.reload
      expect(file_import.processed).to eq(true)
    end
  end
end
