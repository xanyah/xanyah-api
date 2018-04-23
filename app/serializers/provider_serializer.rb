# frozen_string_literal: true

class ProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :shippings_count,
             :created_at,
             :updated_at,
             :name,
             :notes,
             :store_id

  def shippings_count
    object.shippings.size
  end
end
