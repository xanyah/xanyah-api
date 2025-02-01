# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileImport do
  it :has_valid_factory do
    expect(build(:file_import)).to be_valid
  end

  it :is_paranoid do
    file_import = create(:file_import)
    expect(file_import.deleted_at).to be_nil
    expect(described_class.all).to include(file_import)
    file_import.destroy
    expect(file_import.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(file_import)
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
