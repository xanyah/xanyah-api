# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Provider, type: :model do
  it :has_valid_factory do
    expect(build(:provider)).to be_valid
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:provider, name: nil)).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:provider, store: nil)).not_to be_valid
      end
    end
  end

  describe 'search' do
    it :name do
      name = create(:provider).name
      create(:provider)
      expect(Provider.search(name).size).to eq(1)
    end

    it :notes do
      notes = create(:provider).notes
      create(:provider)
      expect(Provider.search(notes).size).to eq(1)
    end
  end
end
