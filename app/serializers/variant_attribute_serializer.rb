# frozen_string_literal: true

class VariantAttributeSerializer < ActiveModel::Serializer
  attributes :id,
             :value,
             :created_at,
             :updated_at

  belongs_to :custom_attribute
end
