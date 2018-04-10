# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variant, type: :model do
  it :has_valid_factory do
    expect(build(:variant)).to be_valid
  end

  describe 'validations' do
    describe 'original_barcode' do
      it :presence do
        expect(build(:variant, original_barcode: nil)).not_to be_valid
      end
    end

    describe 'product' do
      it :presence do
        expect(build(:variant, product: nil)).not_to be_valid
      end
    end

    describe 'provider' do
      it :presence do
        expect(build(:variant, provider: nil)).not_to be_valid
      end
    end

    describe 'buying_price' do
      it :presence do
        expect(build(:variant, buying_price: nil, tax_free_price: 5)).not_to be_valid
      end
    end

    describe 'tax_free_price' do
      it :presence do
        expect(build(:variant, tax_free_price: nil)).not_to be_valid
      end
    end
  end

  describe 'generation' do
    describe 'barcode' do
      it :uniqueness_in_same_store do
        variant1 = create(:variant)
        expect(variant1.barcode).to be_present
        variant2 = create(:variant, product: variant1.product, original_barcode: variant1.barcode)
        expect(variant2.original_barcode).to eq(variant1.barcode)
        expect(variant2.barcode).not_to eq(variant1.barcode)
        variant3 = create(:variant, product: variant1.product, original_barcode: variant1.barcode)
        expect(variant3.original_barcode).to eq(variant1.barcode)
        expect(variant3.original_barcode).to eq(variant2.original_barcode)
        expect(variant3.barcode).not_to eq(variant1.barcode)
        expect(variant3.barcode).not_to eq(variant2.barcode)

        expect(variant1.barcode).not_to include(' ')
        expect(variant2.barcode).not_to include(' ')
        expect(variant3.barcode).not_to include(' ')
      end

      it :uniqueness_in_different_store do
        variant1 = create(:variant)
        expect(variant1.barcode).to be_present
        variant2 = create(:variant, original_barcode: variant1.barcode)
        expect(variant2.original_barcode).to eq(variant1.barcode)
        expect(variant2.barcode).to eq(variant1.barcode)
        variant3 = create(:variant, product: variant2.product, original_barcode: variant2.barcode)
        expect(variant3.original_barcode).to eq(variant1.barcode)
        expect(variant3.original_barcode).to eq(variant2.original_barcode)
        expect(variant3.barcode).not_to eq(variant1.barcode)
        expect(variant3.barcode).not_to eq(variant2.barcode)

        expect(variant1.barcode).not_to include(' ')
        expect(variant2.barcode).not_to include(' ')
        expect(variant3.barcode).not_to include(' ')
      end

      it :gets_original_with_leading_zeros do
        variant = create(:variant, original_barcode: '0000000001')
        expect(variant.barcode).to eq(variant.original_barcode)
      end
    end
  end

  describe 'abilities' do
    describe 'everyone' do
      it :cannot_create do
        expect(Ability.new(build(:user))).not_to be_able_to(:create, Variant.new)
      end
      it :cannot_read do
        expect(Ability.new(build(:user))).not_to be_able_to(:read, Variant.new)
      end
      it :cannot_update do
        expect(Ability.new(build(:user))).not_to be_able_to(:update, Variant.new)
      end
      it :cannot_destroy do
        expect(Ability.new(build(:user))).not_to be_able_to(:destroy, Variant.new)
      end
    end

    describe 'regular' do
      let(:membership) { create(:store_membership, role: :regular) }
      let(:variant) { create(:variant, product: create(:product, store: membership.store)) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(
          :create, build(:variant, product: create(:product, store: membership.store))
        )
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, variant)
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, variant)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, variant)
      end
    end

    describe 'admin' do
      let(:membership) { create(:store_membership, role: :admin) }
      let(:variant) { create(:variant, product: create(:product, store: membership.store)) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(
          :create, build(:variant, product: create(:product, store: membership.store))
        )
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, variant)
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, variant)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, variant)
      end
    end

    describe 'owner' do
      let(:membership) { create(:store_membership, role: :owner) }
      let(:variant) { create(:variant, product: create(:product, store: membership.store)) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(
          :create, build(:variant, product: create(:product, store: membership.store))
        )
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, variant)
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, variant)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, variant)
      end
    end
  end
end
