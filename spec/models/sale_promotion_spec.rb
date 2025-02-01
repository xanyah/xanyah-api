# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalePromotion do
  it :is_paranoid do
    sale_promotion = create(:sale_promotion)
    expect(sale_promotion.deleted_at).to be_nil
    expect(described_class.all).to include(sale_promotion)
    sale_promotion.destroy
    expect(sale_promotion.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(sale_promotion)
  end

  describe 'validations' do
    describe 'sale' do
      it :presence do
        expect(build(:sale_promotion, sale: nil)).not_to be_valid
      end
    end
  end
end
