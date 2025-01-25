# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  it :has_valid_factory do
    expect(build(:order)).to be_valid
  end

  it :is_paranoid do
    order = create(:order)
    expect(order.deleted_at).to be_nil
    expect(described_class.all).to include(order)
    order.destroy
    expect(order.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(order)
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:order, store: nil)).not_to be_valid
      end
    end

    describe 'customer' do
      it :presence do
        expect(build(:order, customer: nil)).not_to be_valid
      end
    end
  end

  describe 'search' do
    it :product_name do
      store = create(:store)
      product1 = create(:product, name: 'Thon', store: store)
      product2 = create(:product, name: 'Mayo', store: store)
      order1 = create(:order, store:          store)
      order2 = create(:order, store:          store)
      create(:order_product, order: order1, product: create(:product, product: product1))
      create(:order_product, order: order2, product: create(:product, product: product2))
      expect(described_class.search('Th').size).to be > 0
      expect(described_class.search('Thon').size).to be > 0
    end

    it :customer_firstname do
      order = create(:order)
      create(:order)
      expect(described_class.search(order.customer.firstname).size).to be > 0
    end

    it :customer_lastname do
      order = create(:order)
      create(:order)
      expect(described_class.search(order.customer.lastname).size).to be > 0
    end
  end
end
