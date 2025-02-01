# frozen_string_literal: true

class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  has_one :store, through: :product

  validates_ownership_of :sale, with: :store

  monetize :amount_cents
end
