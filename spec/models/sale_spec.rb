# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  it :has_valid_factory do
    expect(build(:sale)).to be_valid
  end

  it :is_paranoid do
    sale = create(:sale)
    expect(sale.deleted_at).to be_nil
    expect(described_class.all).to include(sale)
    sale.destroy
    expect(sale.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(sale)
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:sale, store: nil)).not_to be_valid
      end
    end

    describe 'user' do
      it :presence do
        expect(build(:sale, user: nil)).not_to be_valid
      end
    end
  end
end
