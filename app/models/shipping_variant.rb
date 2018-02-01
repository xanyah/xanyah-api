# frozen_string_literal: true

class ShippingVariant < ApplicationRecord
  belongs_to :shipping, optional: false
  belongs_to :variant, optional: false

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :variant_id, uniqueness: {scope: :shipping_id}
  validate :shipping_locked

  protected

  def shipping_locked
    errors.add(:shipping, 'is locked') unless shipping.nil? || shipping.locked_at.nil?
  end
end
