# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :store, optional: false

  def self.search(query)
    query = query.downcase
    where("
      LOWER(firstname) LIKE ?
      OR LOWER(lastname) LIKE ?
      OR LOWER(email) LIKE ?
      OR LOWER(phone) LIKE ?
      OR LOWER(clients.address) LIKE ?
      OR LOWER(notes) LIKE ?
    ", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
