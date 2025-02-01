# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Provider do
  it :has_valid_factory do
    expect(build(:provider)).to be_valid
  end

  it :is_paranoid do
    provider = create(:provider)
    expect(provider.deleted_at).to be_nil
    expect(described_class.all).to include(provider)
    provider.destroy
    expect(provider.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(provider)
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:provider, name: nil)).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:provider, store: nil)).not_to be_valid
      end
    end
  end
end
