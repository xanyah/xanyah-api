# frozen_string_literal: true

class SaleVariant < ApplicationRecord
  belongs_to :sale
  belongs_to :variant

  has_one :store, through: :sale

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
  validate :store_validation

  protected

  def store_validation
    return unless !variant_id.nil? &&
    !Variant.find(variant_id).nil? &&
    Variant.find(variant_id).store.id != sale&.store_id
    errors.add(:variant, 'must belong to store')
  end
end
