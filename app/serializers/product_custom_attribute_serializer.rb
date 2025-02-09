# frozen_string_literal: true

class ProductCustomAttributeSerializer < ActiveModel::Serializer
  attributes :id,
             :value

  belongs_to :custom_attribute
end
