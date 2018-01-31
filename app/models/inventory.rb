class Inventory < ApplicationRecord
  belongs_to :store, optional: false
  has_many :inventory_variants

  def lock
    self.inventory_variants.each do |inventory_variant|
      inventory_variant.variant.update(quantity: inventory_variant.quantity)
    end
    self.locked_at = Time.now
    self.save
  end
end
