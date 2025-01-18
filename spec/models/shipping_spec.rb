# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  it :has_valid_factory do
    expect(build(:shipping)).to be_valid
  end

  it :is_paranoid do
    shipping = create(:shipping)
    expect(shipping.deleted_at).to be_nil
    expect(described_class.all).to include(shipping)
    shipping.destroy
    expect(shipping.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(shipping)
  end

  describe 'lock' do
    let(:shipping) { create(:shipping) }

    it :locks do
      shipping.lock
      shipping.reload
      expect(shipping.locked_at).not_to eq(nil)
    end

    it :updates_variants_quantity do
      svariant1 = create(:shipping_variant, shipping: shipping)
      svariant1_qty = svariant1.variant.quantity
      svariant2 = create(:shipping_variant, shipping: shipping)
      svariant2_qty = svariant2.variant.quantity
      svariant3 = create(:shipping_variant)
      svariant3_qty = svariant3.variant.quantity
      shipping.lock
      svariant1.reload
      svariant2.reload
      svariant3.reload
      expect(svariant1.variant.quantity).to eq(svariant1_qty + svariant1.quantity)
      expect(svariant2.variant.quantity).to eq(svariant2_qty + svariant2.quantity)
      expect(svariant3.variant.quantity).not_to eq(svariant3_qty + svariant3.quantity)
    end
  end
end
