require 'rails_helper'

RSpec.describe StockBackupVariant, type: :model do
  it :has_valid_factory do
    expect(build(:stock_backup_variant)).to be_valid
  end

  describe :validations do
    describe :stock_backup do
      it :presence do
        expect(build(:stock_backup_variant, stock_backup: nil)).not_to be_valid
      end
    end

    describe :variant do
      it :presence do
        expect(build(:stock_backup_variant, variant: nil)).not_to be_valid
      end
    end
  end
end
