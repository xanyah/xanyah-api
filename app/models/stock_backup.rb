class StockBackup < ApplicationRecord
  belongs_to :store, optional: false
  has_many :stock_backup_variants
end
