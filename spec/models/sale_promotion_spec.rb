# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalePromotion, type: :model do
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
