# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  it :has_valid_factory do
    expect(build(:client)).to be_valid
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:client, store: nil)).not_to be_valid
      end
    end
  end
end
