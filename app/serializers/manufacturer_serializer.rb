# frozen_string_literal: true

class ManufacturerSerializer < ActiveModel::Serializer
  attributes :id,
             :products_count,
             :created_at,
             :updated_at,
             :name,
             :notes,
             :store_id

  def products_count
    object.products.size
  end
end
