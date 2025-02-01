# frozen_string_literal: true

class SalePayment < ApplicationRecord
  belongs_to :sale
  belongs_to :payment_type

  has_one :store, through: :sale

  validates_ownership_of :payment_type, with: :store
  validates_ownership_of :sale, with: :store

  monetize :total_amount_cents
end
