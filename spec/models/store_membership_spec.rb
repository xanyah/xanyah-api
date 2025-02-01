# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreMembership do
  it :has_valid_factory do
    expect(build(:store_membership)).to be_valid
  end

  it :is_paranoid do
    store_membership = create(:store_membership)
    expect(store_membership.deleted_at).to be_nil
    expect(described_class.all).to include(store_membership)
    store_membership.destroy
    expect(store_membership.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(store_membership)
  end

  describe 'validations' do
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

  describe 'scopes' do
    before do
      create(:store_membership, role: :regular)
      create(:store_membership, role: :admin)
      create(:store_membership, role: :owner)
    end

    it :has_regular_scope do
      expect(described_class.regular.size).to eq(3)
    end

    it :has_admin_scope do
      expect(described_class.admin.size).to eq(2)
    end

    it :has_owner_scope do
      expect(described_class.owner.size).to eq(1)
    end
  end
end
