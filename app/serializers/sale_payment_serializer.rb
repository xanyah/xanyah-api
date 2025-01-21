# frozen_string_literal: true

class SalePaymentSerializer < ActiveModel::Serializer
  attributes :id, :total_amount_cents, :total_amount_currency
  belongs_to :payment_type
end
