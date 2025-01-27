# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :phone, :address, :notes
end
