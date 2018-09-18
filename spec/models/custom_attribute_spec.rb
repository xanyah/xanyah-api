# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomAttribute, type: :model do
  it :has_valid_factory do
    expect(build(:custom_attribute)).to be_valid
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:custom_attribute, name: nil)).not_to be_valid
      end

      it :uniqueness do
        custom_attribute = create(:custom_attribute)
        expect(
          build(:custom_attribute, name: custom_attribute.name, store: custom_attribute.store)
        ).not_to be_valid
      end
    end

    it :is_paranoid do
      custom_attribute = create(:custom_attribute)
      expect(custom_attribute.deleted_at).to be_nil
      expect(CustomAttribute.all).to include(custom_attribute)
      custom_attribute.destroy
      expect(custom_attribute.deleted_at).not_to be_nil
      expect(CustomAttribute.all).not_to include(custom_attribute)
    end

    describe 'type' do
      it :presence do
        expect(build(:custom_attribute, type: nil)).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:custom_attribute, store: nil)).not_to be_valid
      end
    end
  end
end
