# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockBackup, type: :model do
  it :has_valid_factory do
    expect(build(:stock_backup)).to be_valid
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:stock_backup, store: nil)).not_to be_valid
      end
    end
  end
end
