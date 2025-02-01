# frozen_string_literal: true

class ProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :created_at,
             :updated_at,
             :name,
             :notes,
             :store_id
end
