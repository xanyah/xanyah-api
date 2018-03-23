# frozen_string_literal: true

class InventoryVariant < ApplicationRecord
  belongs_to :inventory, optional: false
  belongs_to :variant, optional: false

  before_validation :set_default_quantity

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :variant_id, uniqueness: {scope: :inventory_id}
  validate :inventory_locked

  protected

  def inventory_locked
    errors.add(:inventory, 'is locked') unless inventory.nil? || inventory.locked_at.nil?
  end

  def set_default_quantity
    self.quantity = 0 if quantity.nil?
  end
end
