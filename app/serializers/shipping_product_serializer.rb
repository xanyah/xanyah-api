# frozen_string_literal: true

class ShippingProductSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :product
end
