# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaleVariantPromotion do
  it :is_paranoid do
    sale_variant_promotion = create(:sale_variant_promotion)
    expect(sale_variant_promotion.deleted_at).to be_nil
    expect(described_class.all).to include(sale_variant_promotion)
    sale_variant_promotion.destroy
    expect(sale_variant_promotion.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(sale_variant_promotion)
  end

  describe 'validations' do
    describe 'amount' do
      it :presence do
        expect(build(:sale_variant_promotion, amount: nil)).not_to be_valid
      end
    end

    describe 'sale_variant' do
      it :presence do
        expect(build(:sale_variant_promotion, sale_variant: nil)).not_to be_valid
      end
    end
  end
end
