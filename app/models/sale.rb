# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :store, optional: false
  belongs_to :user, optional: false

  monetize :total_amount_cents

  has_one :sale_promotion, dependent: :destroy

  has_many :sale_payments, dependent: :destroy
  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products

  accepts_nested_attributes_for :sale_promotion, allow_destroy: true
  accepts_nested_attributes_for :sale_payments, allow_destroy: true
  accepts_nested_attributes_for :sale_products, allow_destroy: true
end
