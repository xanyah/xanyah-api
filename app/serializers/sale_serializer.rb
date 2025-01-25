# frozen_string_literal: true

class SaleSerializer < ActiveModel::Serializer
  attributes :id, :total_amount_cents, :total_amount_currency, :created_at

  belongs_to :customer
  belongs_to :user

  has_one :sale_promotion

  has_many :sale_payments
  has_many :products
end
