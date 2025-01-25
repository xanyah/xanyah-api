# frozen_string_literal: true

class InventorySerializer < ActiveModel::Serializer
  attributes :id,
             :locked_at,
             :created_at,
             :updated_at
end
