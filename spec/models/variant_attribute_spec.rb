require 'rails_helper'

RSpec.describe VariantAttribute, type: :model do
  it :has_valid_factory do
    expect(build(:variant_attribute)).to be_valid
  end

  describe :validations do
    describe :variant do
      it :presence do
        expect(build(:variant_attribute, variant: nil)).not_to be_valid
      end
    end

    describe :custom_attribute do
      it :presence do
        expect(build(:variant_attribute, custom_attribute: nil)).not_to be_valid
      end
    end
  end
end
