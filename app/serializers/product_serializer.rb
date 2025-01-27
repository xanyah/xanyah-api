# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :amount_cents,
             :amount_currency,
             :buying_amount_cents,
             :buying_amount_currency,
             :tax_free_amount_cents,
             :tax_free_amount_currency,
             :sku,
             :upc

  belongs_to :category
  belongs_to :manufacturer
  belongs_to :provider
end
