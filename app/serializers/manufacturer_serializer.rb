# frozen_string_literal: true

class ManufacturerSerializer < ActiveModel::Serializer
  attributes :id,
             :code,
             :name,
             :notes,
             :created_at,
             :updated_at
end
