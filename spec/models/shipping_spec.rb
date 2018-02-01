# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  it :has_valid_factory do
    expect(build(:shipping)).to be_valid
  end

  describe 'lock' do
    let(:shipping) { create(:shipping) }

    it :locks do
      shipping.lock
      shipping.reload
      expect(shipping.locked_at).not_to eq(nil)
    end

    # it :updates_variants_quantity do
    #   ivariant1 = create(:inventory_variant, inventory: inventory)
    #   ivariant2 = create(:inventory_variant, inventory: inventory)
    #   ivariant3 = create(:inventory_variant)
    #   inventory.lock
    #   ivariant1.reload
    #   ivariant2.reload
    #   ivariant3.reload
    #   expect(ivariant1.variant.quantity).to eq(ivariant1.quantity)
    #   expect(ivariant2.variant.quantity).to eq(ivariant2.quantity)
    #   expect(ivariant3.variant.quantity).not_to eq(ivariant3.quantity)
    # end

    # it :creates_backup do
    #   create(:inventory_variant, inventory: inventory)
    #   create(:inventory_variant, inventory: inventory)
    #   create(:inventory_variant)
    #   expect {
    #     inventory.lock
    #   }.to change(StockBackup, :count).by(1)
    #                                   .and change(StockBackupVariant, :count).by(2)
    # end
  end
end
