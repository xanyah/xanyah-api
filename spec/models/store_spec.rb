require 'rails_helper'

RSpec.describe Store, type: :model do
  it :has_valid_factory do
    expect(build(:store)).to be_valid
  end

  describe :validations do
    describe :key do
      it :uniqueness do
        store = create(:store)
        expect(store).to be_valid
        expect(build(:store, key: store.key)).not_to be_valid
      end

      it :presence do
        expect(build(:store, key: nil)).not_to be_valid
      end
    end
  end
end
