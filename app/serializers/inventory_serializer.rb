# frozen_string_literal: true

class InventorySerializer < ActiveModel::Serializer
  attributes :id,
             :inventory_variants_count,
             :locked_at,
             :created_at,
             :updated_at

  def inventory_variants_count
    object.inventory_variants.size
  end
end
