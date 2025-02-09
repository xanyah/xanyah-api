# frozen_string_literal: true

class StoreSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :key,
             :city,
             :address1,
             :address2,
             :zipcode,
             :phone_number,
             :website_url,
             :email_address,
             :country,
             :created_at,
             :updated_at,
             :color,
             :store_membership

  def store_membership
    StoreMembership.find_by(user: scope, store: object)
  end
end
