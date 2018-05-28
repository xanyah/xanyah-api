# frozen_string_literal: true

class VariantAttributeSerializer < ActiveModel::Serializer
  attributes :id,
             :value,
             :created_at,
             :updated_at

  has_one :variant
  has_one :custom_attribute
end
