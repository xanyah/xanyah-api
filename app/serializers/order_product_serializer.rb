# frozen_string_literal: true

class OrderProductSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :product
end
