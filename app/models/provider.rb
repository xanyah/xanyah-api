# frozen_string_literal: true

class Provider < ApplicationRecord
  belongs_to :store, optional: false

  has_many :shippings, dependent: :destroy
  has_many :variants, dependent: :destroy
  has_many :products, through: :variants

  validates :name, presence: true

  def self.search(query)
    query = query.downcase
    where("
      LOWER(providers.name) LIKE ?
      OR LOWER(providers.notes) LIKE ?
    ", "%#{query}%", "%#{query}%")
  end
end
