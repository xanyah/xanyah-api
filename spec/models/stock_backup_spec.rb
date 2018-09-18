# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockBackup, type: :model do
  it :has_valid_factory do
    expect(build(:stock_backup)).to be_valid
  end

  it :is_paranoid do
    stock_backup = create(:stock_backup)
    expect(stock_backup.deleted_at).to be_nil
    expect(StockBackup.all).to include(stock_backup)
    stock_backup.destroy
    expect(stock_backup.deleted_at).not_to be_nil
    expect(StockBackup.all).not_to include(stock_backup)
  end

  describe 'validations' do
    describe 'store' do
      it :presence do
        expect(build(:stock_backup, store: nil)).not_to be_valid
      end
    end
  end
end
