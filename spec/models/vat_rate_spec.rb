# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatRate, type: :model do
  describe 'validations' do
    describe 'country_code' do
      it :uniqueness do
        vat_rate = VatRate.first
        expect(vat_rate).to be_valid
        expect(VatRate.new(country_code: vat_rate.country_code)).not_to be_valid
      end

      it :presence do
        expect(VatRate.new(country_code: nil)).not_to be_valid
      end
    end
  end
end
