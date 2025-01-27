# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping do
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
      expect(shipping.locked_at).not_to be_nil
    end

    it :updates_products_quantity do
      sproduct1 = create(:shipping_product, shipping: shipping)
      sproduct1_qty = sproduct1.product.quantity
      sproduct2 = create(:shipping_product, shipping: shipping)
      sproduct2_qty = sproduct2.product.quantity
      sproduct3 = create(:shipping_product)
      sproduct3_qty = sproduct3.product.quantity
      shipping.lock
      sproduct1.reload
      sproduct2.reload
      sproduct3.reload
      expect(sproduct1.product.quantity).to eq(sproduct1_qty + sproduct1.quantity)
      expect(sproduct2.product.quantity).to eq(sproduct2_qty + sproduct2.quantity)
      expect(sproduct3.product.quantity).not_to eq(sproduct3_qty + sproduct3.quantity)
    end
  end
end
