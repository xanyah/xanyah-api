# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :created_at,
             :updated_at

  has_one :category
  has_one :manufacturer
end
