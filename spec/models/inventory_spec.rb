# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it :has_valid_factory do
    expect(build(:inventory)).to be_valid
  end

  it :is_paranoid do
    inventory = create(:inventory)
    expect(inventory.deleted_at).to be_nil
    expect(Inventory.all).to include(inventory)
    inventory.destroy
    expect(inventory.deleted_at).not_to be_nil
    expect(Inventory.all).not_to include(inventory)
  end

  describe 'lock' do
    let(:inventory) { create(:inventory) }

    it :locks do
      inventory.lock
      inventory.reload
      expect(inventory.locked_at).not_to eq(nil)
    end

    it :updates_variants_quantity do
      ivariant1 = create(:inventory_variant, inventory: inventory)
      ivariant2 = create(:inventory_variant, inventory: inventory)
      ivariant3 = create(:inventory_variant)
      inventory.lock
      ivariant1.reload
      ivariant2.reload
      ivariant3.reload
      expect(ivariant1.variant.quantity).to eq(ivariant1.quantity)
      expect(ivariant2.variant.quantity).to eq(ivariant2.quantity)
      expect(ivariant3.variant.quantity).not_to eq(ivariant3.quantity)
    end

    it :creates_backup do
      create(:inventory_variant, inventory: inventory)
      create(:inventory_variant, inventory: inventory)
      create(:inventory_variant)
      expect {
        inventory.lock
      }.to change(StockBackup, :count).by(1)
                                      .and change(StockBackupVariant, :count).by(2)
    end
  end
end
