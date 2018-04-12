# frozen_string_literal: true

require 'rails_helper'
RSpec.describe FileImportWorker, type: :worker do
  describe 'formats' do
    it :csv do
      object_path = 'tests/variants/import.csv'
      object = S3_BUCKET.object(object_path)
      object.upload_file(Rails.root.join('spec', 'fixtures', 'files', 'variants.csv'))

      FileImportWorker.new.perform object_path, create(:store).id
      expect(Variant.all.size).to eq(1)
      expect(Product.all.size).to eq(1)
    end

    it :json do
      object_path = 'tests/variants/import.json'
      object = S3_BUCKET.object(object_path)
      object.upload_file(Rails.root.join('spec', 'fixtures', 'files', 'variants.json'))

      FileImportWorker.new.perform object_path, create(:store).id
      expect(Variant.all.size).to eq(1)
      expect(Product.all.size).to eq(1)
    end
  end
end
