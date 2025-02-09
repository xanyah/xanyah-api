# frozen_string_literal: true

class SalePayment < ApplicationRecord
  belongs_to :sale
  belongs_to :payment_type

  has_one :store, through: :payment_type

  validates_ownership_of :sale, with: :store

  monetize :total_amount_cents
end
