# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id,
             :state,
             :created_at,
             :updated_at,
             :ordered_at,
             :delivered_at,
             :withdrawn_at,
             :cancelled_at
  belongs_to :customer
end
