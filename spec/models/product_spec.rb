# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  it :has_valid_factory do
    expect(build(:product)).to be_valid
  end

  it :is_paranoid do
    product = create(:product)
    expect(product.deleted_at).to be_nil
    expect(described_class.all).to include(product)
    product.destroy
    expect(product.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(product)
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:product, name: nil)).not_to be_valid
      end
    end

    describe 'category' do
      it :presence do
        expect(build(:product, category: nil)).not_to be_valid
      end
    end

    describe 'manufacturer' do
      it :presence do
        expect(build(:product, manufacturer: nil)).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:product, store: nil)).not_to be_valid
      end
    end
  end
end
