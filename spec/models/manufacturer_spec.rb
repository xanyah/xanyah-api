# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  it :has_valid_factory do
    expect(build(:manufacturer)).to be_valid
  end

  it :is_paranoid do
    manufacturer = create(:manufacturer)
    expect(manufacturer.deleted_at).to be_nil
    expect(described_class.all).to include(manufacturer)
    manufacturer.destroy
    expect(manufacturer.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(manufacturer)
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:manufacturer, name: nil)).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:manufacturer, store: nil)).not_to be_valid
      end
    end
  end

  describe 'search' do
    it :name do
      name = create(:manufacturer).name
      create(:manufacturer)
      expect(described_class.search(name).size).to be > 0
    end

    it :notes do
      notes = create(:manufacturer).notes
      create(:manufacturer)
      expect(described_class.search(notes).size).to be > 0
    end
  end
end
