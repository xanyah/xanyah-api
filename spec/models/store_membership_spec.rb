require 'rails_helper'

RSpec.describe StoreMembership, type: :model do
  it :has_valid_factory do
    expect(build(:store_membership)).to be_valid
  end

  describe :validations do
    it :uniqueness do
      membership = create(:store_membership)
      expect(build(:store_membership, store: membership.store)).to be_valid
      expect(build(:store_membership, user: membership.user)).to be_valid
      expect(build(:store_membership, user: membership.user, store: membership.store)).not_to be_valid
    end

    it :presence do
      expect(build(:store_membership, store: nil)).not_to be_valid
      expect(build(:store_membership, user: nil)).not_to be_valid
    end
  end

  describe :scopes do
    let!(:regular) { create(:store_membership, role: :regular) }
    let!(:admin) { create(:store_membership, role: :admin) }
    let!(:owner) { create(:store_membership, role: :owner) }

    it :has_regular_scope do
      expect(StoreMembership.regular.size).to eq(3)
    end

    it :has_admin_scope do
      expect(StoreMembership.admin.size).to eq(2)
    end

    it :has_owner_scope do
      expect(StoreMembership.owner.size).to eq(1)
    end
  end
end
