# frozen_string_literal: true

class SalePaymentSerializer < ActiveModel::Serializer
  attributes :id, :total
  belongs_to :payment_type
end
