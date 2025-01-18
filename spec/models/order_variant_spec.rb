# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderVariant do
  it :has_valid_factory do
    expect(build(:order_variant)).to be_valid
  end

  it :is_paranoid do
    order_variant = create(:order_variant)
    expect(order_variant.deleted_at).to be_nil
    expect(described_class.all).to include(order_variant)
    order_variant.destroy
    expect(order_variant.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(order_variant)
  end

  describe 'validations' do
    describe 'order' do
      it :presence do
        expect(build(:order_variant, order: nil)).not_to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:order_variant, variant: nil)).not_to be_valid
      end
    end
  end
end
