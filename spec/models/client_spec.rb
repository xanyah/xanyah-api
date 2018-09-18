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

  it :is_paranoid do
    client = create(:client)
    expect(client.deleted_at).to be_nil
    expect(Client.all).to include(client)
    client.destroy
    expect(client.deleted_at).not_to be_nil
    expect(Client.all).not_to include(client)
  end

  describe 'search' do
    it :firstname do
      firstname = create(:client).firstname
      create(:client)
      expect(Client.search(firstname).size).to be > 0
    end

    it :lastname do
      lastname = create(:client).lastname
      create(:client)
      expect(Client.search(lastname).size).to be > 0
    end

    it :email do
      email = create(:client).email
      create(:client)
      expect(Client.search(email).size).to be > 0
    end

    it :phone do
      phone = create(:client).phone
      create(:client)
      expect(Client.search(phone).size).to be > 0
    end

    it :notes do
      notes = create(:client).notes
      create(:client)
      expect(Client.search(notes).size).to be > 0
    end
  end
end
