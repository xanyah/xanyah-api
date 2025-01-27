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

  describe 'search' do
    it :firstname do
      firstname = create(:customer).firstname
      create(:customer)
      expect(described_class.search(firstname).size).to be > 0
    end

    it :lastname do
      lastname = create(:customer).lastname
      create(:customer)
      expect(described_class.search(lastname).size).to be > 0
    end

    it :email do
      email = create(:customer).email
      create(:customer)
      expect(described_class.search(email).size).to be > 0
    end

    it :phone do
      phone = create(:customer).phone
      create(:customer)
      expect(described_class.search(phone).size).to be > 0
    end

    it :notes do
      notes = create(:customer).notes
      create(:customer)
      expect(described_class.search(notes).size).to be > 0
    end
  end
end
