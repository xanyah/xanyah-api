# frozen_string_literal: true

class SaleVariant < ApplicationRecord
  belongs_to :sale
  belongs_to :variant

  has_one :store, through: :sale

  validate :store_validation

  protected

  def store_validation
    return unless !Variant.find(variant_id).nil? && Variant.find(variant_id).store.id != sale.store_id
    errors.add(:variant, 'must belong to store')
  end
end
