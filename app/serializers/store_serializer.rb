# frozen_string_literal: true

class StoreSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :key,
             :address,
             :country,
             :created_at,
             :updated_at,
             :store_membership

  def store_membership
    StoreMembership.find_by(user: scope, store: object)
  end
end
