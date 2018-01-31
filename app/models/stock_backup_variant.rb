class StockBackupVariant < ApplicationRecord
  belongs_to :stock_backup
  belongs_to :variant
end
