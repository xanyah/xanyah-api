# frozen_string_literal: true

class Shipping < ApplicationRecord
  belongs_to :provider, optional: false
  belongs_to :store, optional: false
  has_many :shipping_products, dependent: :destroy

  def lock
    shipping_products.each do |shipping_product|
      shipping_product.product.update(quantity: shipping_product.product.quantity + shipping_product.quantity)
    end
    self.locked_at = Time.zone.now
    save
  end
end
