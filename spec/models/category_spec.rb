# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  it :has_valid_factory do
    expect(build(:category)).to be_valid
  end

  it 'creates a new Category with a SubCategory' do
    expect do
      category = create(:category)
      create(:category, category: category, store: category.store)
    end.to change(described_class, :count).by(2)
  end

  it :is_paranoid do
    category = create(:category)
    expect(category.deleted_at).to be_nil
    expect(described_class.all).to include(category)
    category.destroy
    expect(category.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(category)
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:category, name: nil)).not_to be_valid
      end

      it :uniqueness do
        category = create(:category)
        expect(
          build(:category, name: category.name, store: category.store, category: category.category)
        ).not_to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:category, store: nil)).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:category) { create(:category) }
    let(:subcategory1) { create(:category, store: category.store, category: category) }
    let(:subcategory2) { create(:category, store: category.store, category: category) }
    let(:subcategory3) { create(:category, store: category.store, category: category) }

    it :without_category do
      expect(described_class.without_category).to include(category)
    end

    it :children_of do
      expect(described_class.children_of(category.id)).to include(subcategory1, subcategory2, subcategory3)
    end
  end
end
