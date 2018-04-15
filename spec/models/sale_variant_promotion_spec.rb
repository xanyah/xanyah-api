# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaleVariantPromotion, type: :model do
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
