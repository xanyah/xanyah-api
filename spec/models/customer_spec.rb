# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  it :has_valid_factory do
    expect(build(:customer)).to be_valid
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:customer, store: nil)).not_to be_valid
      end
    end
  end

  it :is_paranoid do
    customer = create(:customer)
    expect(customer.deleted_at).to be_nil
    expect(described_class.all).to include(customer)
    customer.destroy
    expect(customer.deleted_at).not_to be_nil
    expect(described_class.all).not_to include(customer)
  end
end
