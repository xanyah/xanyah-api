# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantAttribute, type: :model do
  it :has_valid_factory do
    expect(build(:variant_attribute)).to be_valid
  end

  it :is_paranoid do
    variant_attribute = create(:variant_attribute)
    expect(variant_attribute.deleted_at).to be_nil
    expect(VariantAttribute.all).to include(variant_attribute)
    variant_attribute.destroy
    expect(variant_attribute.deleted_at).not_to be_nil
    expect(VariantAttribute.all).not_to include(variant_attribute)
  end

  describe 'validations' do
    describe 'variant' do
      it :presence do
        expect(build(:variant_attribute, variant: nil)).not_to be_valid
      end
    end

    describe 'custom_attribute' do
      it :presence do
        expect(build(:variant_attribute, custom_attribute: nil)).not_to be_valid
      end
    end
  end
end
