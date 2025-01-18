# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryVariant do
  it :has_valid_factory do
    expect(build(:inventory_variant)).to be_valid
  end

  it :is_paranoid do
    inventory_variant = create(:inventory_variant)
    expect(inventory_variant.deleted_at).to be_nil
    expect(described_class.all).to include(inventory_variant)
    inventory_variant.destroy
    expect(inventory_variant.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(inventory_variant)
  end

  describe 'validations' do
    describe 'quantity' do
      it :presence do
        expect(create(:shipping_variant, quantity: nil).quantity).to eq(0)
      end

      it 'greater_or_equal_to_0' do
        expect(build(:inventory_variant, quantity: -1)).not_to be_valid
        expect(build(:inventory_variant, quantity: 0)).to be_valid
        expect(build(:inventory_variant, quantity: 1)).to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:inventory_variant, variant: nil)).not_to be_valid
      end

      it :uniqueness_with_inventory do
        ivariant = create(:inventory_variant)
        expect(build(:inventory_variant, inventory: ivariant.inventory, variant: ivariant.variant)).not_to be_valid
      end
    end

    describe 'inventory' do
      it :presence do
        expect(build(:inventory_variant, inventory: nil)).not_to be_valid
      end
    end
  end

  describe 'abilities' do
    describe 'inventory_locked' do
      let(:membership) { create(:store_membership, role: :owner) }
      let(:inventory_variant) { create(:inventory_variant, inventory: create(:inventory, store: membership.store)) }

      before do
        inventory_variant.inventory.lock
      end

      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, inventory_variant)
      end

      it :cannot_create do
        expect(Ability.new(membership.user)).not_to be_able_to(:create, inventory_variant)
      end

      it :cannot_update do
        expect(Ability.new(membership.user)).not_to be_able_to(:update, inventory_variant)
      end

      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, inventory_variant)
      end
    end
  end
end
