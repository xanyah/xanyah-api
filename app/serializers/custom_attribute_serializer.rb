# frozen_string_literal: true

class CustomAttributeSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :type,
             :created_at,
             :updated_at
end
