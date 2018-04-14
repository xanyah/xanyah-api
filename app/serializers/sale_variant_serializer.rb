# frozen_string_literal: true

class SaleVariantSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :unit_price

  belongs_to :variant

  has_one :sale_variant_promotion
end
