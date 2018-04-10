# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderVariant, type: :model do
  it :has_valid_factory do
    expect(build(:order_variant)).to be_valid
  end

  describe 'validations' do
    describe 'order' do
      it :presence do
        expect(build(:order_variant, order: nil)).not_to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:order_variant, variant: nil)).not_to be_valid
      end
    end
  end
end
