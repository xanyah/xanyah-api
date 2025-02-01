# frozen_string_literal: true

class ShippingProduct < ApplicationRecord
  belongs_to :shipping, optional: false
  belongs_to :product, optional: false

  has_one :store, through: :shipping

  validates_ownership_of :product, with: :store

  validates :product_id, uniqueness: { scope: :shipping_id }
  validate :shipping_locked

  protected

  def shipping_locked
    errors.add(:shipping, :validated) if shipping.validated?
  end
end
