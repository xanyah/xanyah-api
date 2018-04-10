# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :client
  has_one :store
end
