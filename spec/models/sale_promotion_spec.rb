# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalePromotion, type: :model do
  it :is_paranoid do
    sale_promotion = create(:sale_promotion)
    expect(sale_promotion.deleted_at).to be_nil
    expect(SalePromotion.all).to include(sale_promotion)
    sale_promotion.destroy
    expect(sale_promotion.deleted_at).not_to be_nil
    expect(SalePromotion.all).not_to include(sale_promotion)
  end

  describe 'validations' do
    describe 'amount' do
      it :presence do
        expect(build(:sale_promotion, amount: nil)).not_to be_valid
      end
    end

    describe 'sale' do
      it :presence do
        expect(build(:sale_promotion, sale: nil)).not_to be_valid
      end
    end
  end
end
