# frozen_string_literal: true

class ShippingSerializer < ActiveModel::Serializer
  attributes :id,
             :address,
             :locked_at,
             :created_at,
             :updated_at

  belongs_to :provider
end
