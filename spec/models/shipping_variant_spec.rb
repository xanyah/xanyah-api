# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingVariant, type: :model do
  it :has_valid_factory do
    expect(build(:shipping_variant)).to be_valid
  end

  it :is_paranoid do
    shipping_variant = create(:shipping_variant)
    expect(shipping_variant.deleted_at).to be_nil
    expect(ShippingVariant.all).to include(shipping_variant)
    shipping_variant.destroy
    expect(shipping_variant.deleted_at).not_to be_nil
    expect(ShippingVariant.all).not_to include(shipping_variant)
  end

  describe 'validations' do
    describe 'quantity' do
      it :presence do
        expect(create(:shipping_variant, quantity: nil).quantity).to eq(0)
      end

      it :greater_or_equal_to_0 do
        expect(build(:shipping_variant, quantity: -1)).not_to be_valid
        expect(build(:shipping_variant, quantity: 0)).to be_valid
        expect(build(:shipping_variant, quantity: 1)).to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:shipping_variant, variant: nil)).not_to be_valid
      end

      it :uniqueness_with_shipping do
        ivariant = create(:shipping_variant)
        expect(build(:shipping_variant, shipping: ivariant.shipping, variant: ivariant.variant)).not_to be_valid
      end
    end

    describe 'shipping' do
      it :presence do
        expect(build(:shipping_variant, shipping: nil)).not_to be_valid
      end
    end
  end

  describe 'abilities' do
    describe 'shipping_locked' do
      let(:membership) { create(:store_membership, role: :owner) }
      let(:shipping_variant) { create(:shipping_variant, shipping: create(:shipping, store: membership.store)) }

      before do
        shipping_variant.shipping.lock
      end

      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, shipping_variant)
      end

      it :cannot_create do
        expect(Ability.new(membership.user)).not_to be_able_to(:create, shipping_variant)
      end

      it :cannot_update do
        expect(Ability.new(membership.user)).not_to be_able_to(:update, shipping_variant)
      end

      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, shipping_variant)
      end
    end
  end
end
