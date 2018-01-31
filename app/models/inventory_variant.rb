class InventoryVariant < ApplicationRecord
  belongs_to :inventory, optional: false
  belongs_to :variant, optional: false
  
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :variant_id, uniqueness: { scope: :inventory_id }
  validate :inventory_locked

  protected
  def inventory_locked
    errors.add(:inventory, 'is locked') unless self.inventory.nil? || self.inventory.locked_at.nil?
  end
end
