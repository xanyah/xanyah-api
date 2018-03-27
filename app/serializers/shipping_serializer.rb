# frozen_string_literal: true

class ShippingSerializer < ActiveModel::Serializer
  attributes :id,
             :shipping_variants_count,
             :locked_at,
             :created_at,
             :updated_at

  belongs_to :provider

  def shipping_variants_count
    object.shipping_variants.size
  end
end
