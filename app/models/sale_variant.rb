# frozen_string_literal: true

class SaleVariant < ApplicationRecord
  before_validation :set_price

  belongs_to :sale
  belongs_to :variant

  has_one :store, through: :sale

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :store_validation

  after_create :update_variant

  has_one :sale_variant_promotion, dependent: :destroy

  accepts_nested_attributes_for :sale_variant_promotion, allow_destroy: true

  protected

  def store_validation
    return unless !variant_id.nil? &&
                  !Variant.find(variant_id).nil? &&
                  Variant.find(variant_id).store.id != sale&.store_id

    errors.add(:variant, 'must belong to store')
  end

  def update_variant
    variant.update(quantity: variant.quantity - quantity)
  end

  def set_price
    self.unit_price = unit_price&.round(2)
  end
end
