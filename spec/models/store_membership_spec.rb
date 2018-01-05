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

  describe :abilities do
    describe :everyone do
      it :cannot_create do
        expect(Ability.new(build(:user))).not_to be_able_to(:create, build(:store_membership))
      end
      it :cannot_read do
        expect(Ability.new(build(:user))).not_to be_able_to(:read, build(:store_membership))
      end
      it :cannot_update do
        expect(Ability.new(build(:user))).not_to be_able_to(:update, build(:store_membership))
      end
      it :cannot_destroy do
        expect(Ability.new(build(:user))).not_to be_able_to(:destroy, build(:store_membership))
      end
    end

    describe :regular do
      let(:membership) { create(:store_membership, role: :regular) }
      it :cannot_create do
        expect(Ability.new(membership.user)).not_to be_able_to(:create, build(:store_membership, store: membership.store))
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, build(:store_membership, store: membership.store))
      end
      it :cannot_update do
        expect(Ability.new(membership.user)).not_to be_able_to(:update, build(:store_membership, store: membership.store))
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, build(:store_membership, store: membership.store))
      end
    end

    describe :admin do
      let(:membership) { create(:store_membership, role: :admin) }
      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(:create, build(:store_membership, store: membership.store))
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, build(:store_membership, store: membership.store))
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, build(:store_membership, store: membership.store))
      end
      it :can_destroy_regular_admin do
        expect(Ability.new(membership.user)).to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :regular))
        expect(Ability.new(membership.user)).to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :admin))
      end
      it :cannot_destroy_owner do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :owner))
      end
    end

    describe :owner do
      let(:membership) { create(:store_membership, role: :owner) }
      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(:create, build(:store_membership, store: membership.store))
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, build(:store_membership, store: membership.store))
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, build(:store_membership, store: membership.store))
      end
      it :can_destroy_regular_admin do
        expect(Ability.new(membership.user)).to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :regular))
        expect(Ability.new(membership.user)).to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :admin))
      end
      it :cannot_destroy_owner do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, build(:store_membership, store: membership.store, role: :owner))
      end
    end

    describe :with_other_store_permissions do
      let(:regular_membership) { create(:store_membership, role: :regular) }
      let(:admin_membership) { create(:store_membership, role: :admin) }
      let(:owner_membership) { create(:store_membership, role: :owner) }
      it :cannot_create do
        expect(Ability.new(regular_membership)).not_to be_able_to(:create, build(:store_membership))
        expect(Ability.new(admin_membership)).not_to be_able_to(:create, build(:store_membership))
        expect(Ability.new(owner_membership)).not_to be_able_to(:create, build(:store_membership))
      end
      it :cannot_read do
        expect(Ability.new(regular_membership)).not_to be_able_to(:read, build(:store_membership))
        expect(Ability.new(admin_membership)).not_to be_able_to(:read, build(:store_membership))
        expect(Ability.new(owner_membership)).not_to be_able_to(:read, build(:store_membership))
      end
      it :cannot_update do
        expect(Ability.new(regular_membership)).not_to be_able_to(:update, build(:store_membership))
        expect(Ability.new(admin_membership)).not_to be_able_to(:update, build(:store_membership))
        expect(Ability.new(owner_membership)).not_to be_able_to(:update, build(:store_membership))
      end
      it :cannot_destroy do
        expect(Ability.new(regular_membership)).not_to be_able_to(:destroy, build(:store_membership))
        expect(Ability.new(admin_membership)).not_to be_able_to(:destroy, build(:store_membership))
        expect(Ability.new(owner_membership)).not_to be_able_to(:destroy, build(:store_membership))
      end
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
