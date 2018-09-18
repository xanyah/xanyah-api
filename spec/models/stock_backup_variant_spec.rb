# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockBackupVariant, type: :model do
  it :has_valid_factory do
    expect(build(:stock_backup_variant)).to be_valid
  end

  it :is_paranoid do
    stock_backup_variant = create(:stock_backup_variant)
    expect(stock_backup_variant.deleted_at).to be_nil
    expect(StockBackupVariant.all).to include(stock_backup_variant)
    stock_backup_variant.destroy
    expect(stock_backup_variant.deleted_at).not_to be_nil
    expect(StockBackupVariant.all).not_to include(stock_backup_variant)
  end

  describe 'validations' do
    describe 'stock_backup' do
      it :presence do
        expect(build(:stock_backup_variant, stock_backup: nil)).not_to be_valid
      end
    end

    describe 'variant' do
      it :presence do
        expect(build(:stock_backup_variant, variant: nil)).not_to be_valid
      end
    end
  end
end
