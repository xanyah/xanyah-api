# frozen_string_literal: true

class OrderVariantSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  has_one :variant
end
