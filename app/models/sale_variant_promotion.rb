# frozen_string_literal: true

class SaleVariantPromotion < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :sale_variant
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}

  enum type: %i[
    flat_discount
    percent_discount
  ]
end
