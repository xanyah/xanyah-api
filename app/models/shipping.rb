# frozen_string_literal: true

class Shipping < ApplicationRecord
  belongs_to :provider, optional: false
  belongs_to :store, optional: false
  has_many :shipping_variants, dependent: :destroy

  def lock
    shipping_variants.each do |shipping_variant|
      shipping_variant.variant.update(quantity: shipping_variant.variant.quantity + shipping_variant.quantity)
    end
    self.locked_at = Time.zone.now
    save
  end
end
