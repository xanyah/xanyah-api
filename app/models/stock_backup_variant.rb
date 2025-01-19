# frozen_string_literal: true

class StockBackupVariant < ApplicationRecord
  belongs_to :stock_backup
  belongs_to :variant

  has_one :store, through: :stock_backup
end
