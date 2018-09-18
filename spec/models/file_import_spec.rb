# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileImport, type: :model do
  it :has_valid_factory do
    expect(build(:file_import)).to be_valid
  end

  describe 'callbacks' do
    it :worker_creation do
      expect {
        create(:file_import)
      }.to change(FileImportWorker.jobs, :size).by(1)
    end
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:file_import, store: nil)).not_to be_valid
      end
    end

    describe 'user' do
      it :presence do
        expect(build(:file_import, user: nil)).not_to be_valid
      end
    end
  end
end
