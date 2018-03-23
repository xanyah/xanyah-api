# frozen_string_literal: true

class ShippingVariantSerializer < ActiveModel::Serializer
  attributes :id,
             :quantity,
             :created_at,
             :updated_at

  belongs_to :variant
  belongs_to :shipping
end
