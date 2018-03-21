# frozen_string_literal: true

class InventoryVariantSerializer < ActiveModel::Serializer
  attributes :id,
             :quantity,
             :created_at,
             :updated_at

  belongs_to :variant
  belongs_to :inventory
end
