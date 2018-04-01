# frozen_string_literal: true

class ClientSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :phone, :address, :notes
  belongs_to :store
end
