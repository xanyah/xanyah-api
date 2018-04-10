# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id,
             :original_barcode,
             :barcode,
             :buying_price,
             :tax_free_price,
             :price,
             :ratio,
             :quantity,
             :default,
             :created_at,
             :updated_at

  belongs_to :product, serializer: ProductSerializer
  belongs_to :provider
end
