# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it :has_valid_factory do
    expect(build(:category)).to be_valid
  end

  it 'creates a new Category with a SubCategory' do
    expect {
      category = create(:category)
      create(:category, category: category)
    }.to change(Category, :count).by(2)
  end

  it :is_paranoid do
    category = create(:category)
    expect(category.deleted_at).to be_nil
    expect(Category.all).to include(category)
    category.destroy
    expect(category.deleted_at).not_to be_nil
    expect(Category.all).not_to include(category)
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

    describe 'tva' do
      it :presence do
        expect(build(:category, tva: nil)).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:category) { create(:category) }
    let(:subcategory_1) { create(:category, category: category) }
    let(:subcategory_2) { create(:category, category: category) }
    let(:subcategory_3) { create(:category, category: category) }

    it :without_category do
      expect(Category.without_category).to include(category)
    end

    it :children_of do
      expect(Category.children_of(category.id)).to include(subcategory_1, subcategory_2, subcategory_3)
    end
  end
end
