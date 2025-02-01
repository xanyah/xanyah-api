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

  describe 'validate' do
    let(:shipping) { create(:shipping) }

    it :validates do
      shipping.validate!
      shipping.reload
      expect(shipping.validated_at).not_to be_nil
    end

    it :updates_products_quantity do
      sproduct1 = create(:shipping_product, shipping: shipping)
      sproduct1_qty = sproduct1.product.quantity
      sproduct2 = create(:shipping_product, shipping: shipping)
      sproduct2_qty = sproduct2.product.quantity
      sproduct3 = create(:shipping_product)
      sproduct3_qty = sproduct3.product.quantity
      shipping.validate!
      expect(sproduct1.reload.product.quantity).to eq(sproduct1_qty + sproduct1.quantity)
      expect(sproduct2.reload.product.quantity).to eq(sproduct2_qty + sproduct2.quantity)
      expect(sproduct3.reload.product.quantity).not_to eq(sproduct3_qty + sproduct3.quantity)
    end
  end

  describe 'cancel' do
    let(:shipping) { create(:shipping) }

    it :cancels do
      shipping.update(state: :validated)
      shipping.cancel!
      shipping.reload
      expect(shipping.cancelled_at).not_to be_nil
    end

    it :updates_products_quantity do
      sproduct1 = create(:shipping_product, shipping: shipping)
      sproduct1_qty = sproduct1.product.quantity
      sproduct2 = create(:shipping_product, shipping: shipping)
      sproduct2_qty = sproduct2.product.quantity
      sproduct3 = create(:shipping_product)
      sproduct3_qty = sproduct3.product.quantity
      shipping.update(state: :validated)
      shipping.reload.cancel!
      expect(sproduct1.reload.product.quantity).to eq(sproduct1_qty - sproduct1.quantity)
      expect(sproduct2.reload.product.quantity).to eq(sproduct2_qty - sproduct2.quantity)
      expect(sproduct3.reload.product.quantity).not_to eq(sproduct3_qty - sproduct3.quantity)
    end
  end
end
