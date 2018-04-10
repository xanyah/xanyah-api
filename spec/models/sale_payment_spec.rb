# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalePayment, type: :model do
  it :has_valid_factory do
    expect(build(:sale_payment)).to be_valid
  end

  describe 'validations' do
    describe 'sale' do
      it :presence do
        expect(build(:sale_payment, sale: nil)).not_to be_valid
      end
    end

    describe 'payment type' do
      it :presence do
        expect(build(:sale_payment, payment_type: nil)).not_to be_valid
      end
    end
  end
end
