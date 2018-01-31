class Inventory < ApplicationRecord
  belongs_to :store, optional: false
  has_many :inventory_variants

  def lock
    backup = StockBackup.create(store: self.store)
    self.inventory_variants.each do |inventory_variant|
      StockBackupVariant.create(variant: inventory_variant.variant, stock_backup: backup, quantity: inventory_variant.variant.quantity)
      inventory_variant.variant.update(quantity: inventory_variant.quantity)
    end
    self.locked_at = Time.now
    self.save
  end
end
