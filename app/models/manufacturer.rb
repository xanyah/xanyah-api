# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  belongs_to :store, optional: false

  has_many :products, dependent: :destroy

  validates :name, presence: true

  def self.search(query)
    query = query.downcase
    where("
      LOWER(manufacturers.name) LIKE ?
      OR LOWER(manufacturers.notes) LIKE ?
    ", "%#{query}%", "%#{query}%")
  end
end
