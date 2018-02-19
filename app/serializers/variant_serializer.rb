# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id,
             :original_barcode,
             :barcode,
             :buying_price,
             :tax_free_price,
             :ratio,
             :quantity,
             :default,
             :created_at,
             :updated_at

  has_one :product, serializer: ProductSerializer
  has_one :provider
end
