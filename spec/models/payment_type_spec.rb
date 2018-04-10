# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentType, type: :model do
  it :has_valid_factory do
    expect(build(:payment_type)).to be_valid
  end

  describe 'validations' do
    describe 'name' do
      it :presence do
        expect(build(:payment_type, name: nil)).not_to be_valid
      end

      it :uniqueness_by_store do
        pt = create(:payment_type)
        expect(build(:payment_type, store: pt.store, name: pt.name)).not_to be_valid
        expect(build(:payment_type, name: pt.name)).to be_valid
      end
    end

    describe 'store' do
      it :presence do
        expect(build(:payment_type, store: nil)).not_to be_valid
      end
    end
  end
end
