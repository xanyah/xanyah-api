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
end
