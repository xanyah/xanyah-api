# frozen_string_literal: true

class SalePromotionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount
end
