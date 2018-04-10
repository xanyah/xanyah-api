# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  it :has_valid_factory do
    expect(build(:sale)).to be_valid
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
end
