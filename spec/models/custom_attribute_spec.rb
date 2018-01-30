require 'rails_helper'

RSpec.describe CustomAttribute, type: :model do
  it :has_valid_factory do
    expect(build(:custom_attribute)).to be_valid
  end

  describe :validations do
    describe :name do
      it :presence do
        expect(build(:custom_attribute, name: nil)).not_to be_valid
      end
    end

    describe :type do
      it :presence do
        expect(build(:custom_attribute, type: nil)).not_to be_valid
      end
    end

    describe :store do
      it :presence do
        expect(build(:custom_attribute, store: nil)).not_to be_valid
      end
    end
  end
end
