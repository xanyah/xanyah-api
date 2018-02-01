# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model do
  it :has_valid_factory do
    expect(build(:store)).to be_valid
  end

  describe 'validations' do
    describe 'key' do
      it :uniqueness do
        store = create(:store)
        expect(store).to be_valid
        expect(build(:store, key: store.key)).not_to be_valid
      end

      it :presence do
        expect(build(:store, key: nil)).not_to be_valid
      end
    end

    describe 'country' do
      it :presence do
        expect(build(:store, country: nil)).not_to be_valid
      end

      it :valid do
        expect(build(:store, country: ISO3166::Country.all.map(&:alpha2).sample)).to be_valid
        expect(build(:store, country: 'FE')).not_to be_valid
      end
    end
  end

  describe 'abilities' do
    describe 'everyone' do
      it :can_create do
        expect(Ability.new(build(:user))).to be_able_to(:create, Store.new)
      end
      it :cannot_read do
        expect(Ability.new(build(:user))).not_to be_able_to(:read, Store.new)
      end
      it :cannot_update do
        expect(Ability.new(build(:user))).not_to be_able_to(:update, Store.new)
      end
      it :cannot_destroy do
        expect(Ability.new(build(:user))).not_to be_able_to(:destroy, Store.new)
      end
    end

    describe 'regular' do
      let(:membership) { create(:store_membership, role: :regular) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(:create, Store.new)
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, membership.store)
      end
      it :cannot_update do
        expect(Ability.new(membership.user)).not_to be_able_to(:update, membership.store)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, membership.store)
      end
    end

    describe 'admin' do
      let(:membership) { create(:store_membership, role: :admin) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(:create, Store.new)
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, membership.store)
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, membership.store)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, membership.store)
      end
    end

    describe 'owner' do
      let(:membership) { create(:store_membership, role: :owner) }

      it :can_create do
        expect(Ability.new(membership.user)).to be_able_to(:create, Store.new)
      end
      it :can_read do
        expect(Ability.new(membership.user)).to be_able_to(:read, membership.store)
      end
      it :can_update do
        expect(Ability.new(membership.user)).to be_able_to(:update, membership.store)
      end
      it :cannot_destroy do
        expect(Ability.new(membership.user)).not_to be_able_to(:destroy, membership.store)
      end
    end
  end

  describe 'scopes' do
    let(:store) { create(:store) }

    before do
      create(:store_membership, store: store, role: :regular)
      create(:store_membership, store: store, role: :admin)
      create(:store_membership, store: store, role: :owner)
    end

    it :has_regular_scope do
      expect(store.users.size).to eq(3)
    end

    it :has_admin_scope do
      expect(store.admins.size).to eq(2)
    end

    it :has_owner_scope do
      expect(store.owners.size).to eq(1)
    end
  end
end
