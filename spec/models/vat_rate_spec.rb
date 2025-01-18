# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatRate do
  describe 'validations' do
    describe 'country_code' do
      it :uniqueness do
        vat_rate = described_class.first
        expect(vat_rate).to be_valid
        expect(described_class.new(country_code: vat_rate.country_code)).not_to be_valid
      end

      it :presence do
        expect(described_class.new(country_code: nil)).not_to be_valid
      end
    end
  end
end
