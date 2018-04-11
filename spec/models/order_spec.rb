# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it :has_valid_factory do
    expect(build(:order)).to be_valid
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:order, store: nil)).not_to be_valid
      end
    end

    describe 'client' do
      it :presence do
        expect(build(:order, client: nil)).not_to be_valid
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
      create(:order_variant, order: order1, variant: create(:variant, product: product1))
      create(:order_variant, order: order2, variant: create(:variant, product: product2))
      expect(Order.search('Th').size).to eq(1)
      expect(Order.search('Thon').size).to eq(1)
    end

    it :client_firstname do
      order = create(:order)
      create(:order)
      expect(Order.search(order.client.firstname).size).to eq(1)
    end

    it :client_lastname do
      order = create(:order)
      create(:order)
      expect(Order.search(order.client.lastname).size).to eq(1)
    end
  end
end
