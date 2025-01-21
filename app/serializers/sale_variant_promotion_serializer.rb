# frozen_string_literal: true

class SaleVariantPromotionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount_cents, :amount_currency
end
