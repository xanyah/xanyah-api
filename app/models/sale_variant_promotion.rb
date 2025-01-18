# frozen_string_literal: true

class SaleVariantPromotion < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :sale_variant
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum :type, { flat_discount: 0, percent_discount: 1 }
end
