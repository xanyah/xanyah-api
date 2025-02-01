# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory do
  it :has_valid_factory do
    expect(build(:inventory)).to be_valid
  end

  it :is_paranoid do
    inventory = create(:inventory)
    expect(inventory.deleted_at).to be_nil
    expect(described_class.all).to include(inventory)
    inventory.destroy
    expect(inventory.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(inventory)
  end

  describe 'lock' do
    let(:inventory) { create(:inventory) }

    it :locks do
      inventory.lock
      inventory.reload
      expect(inventory.locked_at).not_to be_nil
    end

    # it :updates_products_quantity do
    #   iproduct1 = create(:inventory_product, inventory: inventory)
    #   iproduct2 = create(:inventory_product, inventory: inventory)
    #   iproduct3 = create(:inventory_product)
    #   inventory.lock
    #   iproduct1.reload
    #   iproduct2.reload
    #   iproduct3.reload
    #   expect(iproduct1.product.quantity).to eq(iproduct1.quantity)
    #   expect(iproduct2.product.quantity).to eq(iproduct2.quantity)
    #   expect(iproduct3.product.quantity).not_to eq(iproduct3.quantity)
    # end
  end
end
