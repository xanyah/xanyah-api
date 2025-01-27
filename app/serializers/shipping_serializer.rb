# frozen_string_literal: true

class ShippingSerializer < ActiveModel::Serializer
  attributes :id,
             :state,
             :cancelled_at,
             :validated_at,
             :created_at,
             :updated_at

  belongs_to :provider
end
