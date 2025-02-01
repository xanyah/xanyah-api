# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store do
  it :has_valid_factory do
    expect(build(:store)).to be_valid
  end

  it :is_paranoid do
    store = create(:store)
    expect(store.deleted_at).to be_nil
    expect(described_class.all).to include(store)
    store.destroy
    expect(store.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(store)
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
