# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at
  belongs_to :client
  has_many :order_variants
end
