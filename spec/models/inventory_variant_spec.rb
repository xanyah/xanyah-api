require 'rails_helper'

RSpec.describe InventoryVariant, type: :model do
  it :has_valid_factory do
    expect(build(:inventory_variant)).to be_valid
  end

  describe :validations do
    describe :quantity do
      it :presence do
        expect(build(:inventory_variant, quantity: nil)).not_to be_valid
      end

      it :greater_or_equal_to_0 do
        expect(build(:inventory_variant, quantity: -1)).not_to be_valid
        expect(build(:inventory_variant, quantity: 0)).to be_valid
        expect(build(:inventory_variant, quantity: 1)).to be_valid
      end
    end

    describe :variant do
      it :presence do
        expect(build(:inventory_variant, variant: nil)).not_to be_valid
      end

      it :uniqueness_with_inventory do
        ivariant = create(:inventory_variant)
        expect(build(:inventory_variant, inventory: ivariant.inventory, variant: ivariant.variant)).not_to be_valid
      end
    end

    describe :inventory do
      it :presence do
        expect(build(:inventory_variant, inventory: nil)).not_to be_valid
      end
    end
  end
end
