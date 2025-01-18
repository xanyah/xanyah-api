# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :store, optional: false
  has_many :inventory_variants, dependent: :destroy

  def lock
    backup = StockBackup.create(store: store)
    inventory_variants.each do |inventory_variant|
      StockBackupVariant.create(
        variant: inventory_variant.variant,
        stock_backup: backup,
        quantity: inventory_variant.variant.quantity
      )
      inventory_variant.variant.update(quantity: inventory_variant.quantity)
    end
    self.locked_at = Time.zone.now
    save
  end
end
