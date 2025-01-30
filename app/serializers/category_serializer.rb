# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  belongs_to :category
  belongs_to :vat_rate
end
