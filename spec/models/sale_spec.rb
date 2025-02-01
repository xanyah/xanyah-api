# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale do
  it :has_valid_factory do
    expect(build(:sale)).to be_valid
  end

  it :is_paranoid do
    sale = create(:sale)
    expect(sale.deleted_at).to be_nil
    expect(described_class.all).to include(sale)
    sale.destroy
    expect(sale.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(sale)
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:sale, store: nil)).not_to be_valid
      end
    end

    describe 'user' do
      it :presence do
        expect(build(:sale, user: nil)).not_to be_valid
      end
    end
  end

  it 'removes quantity from products' do
    product = create(:product, quantity: 10)
    create(:sale, sale_products_attributes: [{ product_id: product.id, quantity: 2 }])
    expect(product.reload.quantity).to eq(8)
  end
end
