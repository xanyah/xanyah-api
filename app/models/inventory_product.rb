class InventoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :inventory
  has_one :store, through: :inventory

  validates :product_id, uniqueness: { scope: :inventory_id }
  validate :inventory_locked

  protected

  def inventory_locked
    errors.add(:inventory, 'is locked') unless inventory.nil? || inventory.locked_at.nil?
  end
end
