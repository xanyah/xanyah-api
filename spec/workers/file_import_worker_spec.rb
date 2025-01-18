# frozen_string_literal: true

require 'rails_helper'
RSpec.describe FileImportWorker, type: :worker do
  describe 'formats' do
    it :csv do
      file = Rails.root.join('spec/fixtures/files/variants.csv').open
      membership = create(:store_membership, role: :admin)

      file_import = FileImport.create(user: membership.user, store: membership.store)
      file_import.file.attach io: file, filename: 'variants.csv', content_type: 'text/csv'

      expect(file_import.processed).to be(false)
      described_class.new.perform file_import.id

      expect(Category.all.size).to be > 0
      expect(Manufacturer.all.size).to be > 0
      expect(Product.all.size).to be > 0
      expect(Provider.all.size).to be > 0
      expect(Variant.all.size).to be > 0

      file_import.reload
      expect(file_import.processed).to be(true)
    end

    it :json do
      file = Rails.root.join('spec/fixtures/files/variants.json').open
      membership = create(:store_membership, role: :admin)

      file_import = FileImport.create(user: membership.user, store: membership.store)
      file_import.file.attach io: file, filename: 'variants.json', content_type: 'application/json'

      expect(file_import.processed).to be(false)
      described_class.new.perform file_import.id

      expect(Category.all.size).to be > 0
      expect(Manufacturer.all.size).to be > 0
      expect(Product.all.size).to be > 0
      expect(Provider.all.size).to be > 0
      expect(Variant.all.size).to be > 0

      file_import.reload
      expect(file_import.processed).to be(true)
    end
  end
end
