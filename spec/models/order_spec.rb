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
end
