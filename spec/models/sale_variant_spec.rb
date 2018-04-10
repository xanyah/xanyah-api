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
end
