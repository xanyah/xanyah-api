# frozen_string_literal: true

class PaymentType < ApplicationRecord
  belongs_to :store, optional: false

  validates :name, uniqueness: { scope: :store_id }, presence: true
end
