# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :manufacturer, optional: false
  belongs_to :store, optional: false

  has_many :product_custom_attributes, dependent: :destroy

  monetize :buying_amount_cents, :tax_free_amount_cents, :amount_cents

  validates :name, presence: true
  validates :sku, uniqueness: { scope: :store }
end
