# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatRate, type: :model do
  it :has_valid_factory do
    expect(build(:vat_rate)).to be_valid
  end

  describe 'validations' do
    describe 'email' do
      it :uniqueness do
        vat_rate = create(:vat_rate)
        expect(vat_rate).to be_valid
        expect(build(:vat_rate, country_code: vat_rate.country_code)).not_to be_valid
      end

      it :presence do
        expect(build(:vat_rate, country_code: nil)).not_to be_valid
      end
    end
  end
end
