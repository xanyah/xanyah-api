# frozen_string_literal: true

class SaleSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :created_at

  belongs_to :client
  belongs_to :store
  belongs_to :user

  has_one :sale_promotion

  has_many :sale_payments
  has_many :sale_variants
end
