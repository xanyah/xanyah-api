# frozen_string_literal: true

class OrderVariant < ApplicationRecord
  belongs_to :variant, optional: false
  belongs_to :order, optional: false
  has_one :store, through: :order

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
  validate :store_validation

  protected

  def store_validation
    return unless !variant_id.nil? &&
    !Variant.find(variant_id).nil? &&
    Variant.find(variant_id).store.id != order&.store_id

    errors.add(:variant, 'must belong to store')
  end
end
