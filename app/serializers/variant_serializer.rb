# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id,
             :original_barcode,
             :barcode,
             :buying_amount_cents,
             :buying_amount_currency,
             :tax_free_amount_cents,
             :tax_free_amount_currency,
             :price,
             :ratio,
             :quantity,
             :default,
             :created_at,
             :updated_at

  belongs_to :product, serializer: ProductSerializer
  belongs_to :provider

  has_many :variant_attributes
end
