# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaleVariant, type: :model do
  it :has_valid_factory do
    expect(build(:sale_variant)).to be_valid
  end

  describe 'validations' do
    describe 'sale' do
      it :presence do
        expect(build(:sale_variant, sale: nil)).not_to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:sale_variant, variant: nil)).not_to be_valid
      end
    end
  end

  describe 'callbacks' do
    it :updates_variant_quantity do
      store = create(:store)
      variant = create(:variant, quantity: 2, product: create(:product, store: store))
      create(:sale_variant, quantity: 1, variant: variant, sale: create(:sale, store: store))
      variant.reload
      expect(variant.quantity).to eq(1)
    end
  end
end
