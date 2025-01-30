# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category, optional: false
  belongs_to :manufacturer, optional: false
  belongs_to :store, optional: false

  has_many :product_custom_attributes, dependent: :destroy

  monetize :buying_amount_cents, :tax_free_amount_cents, :amount_cents

  validates :name, presence: true
  validates :sku, uniqueness: { scope: :store }

  has_many_attached :images do |attachable|
    # Used for OpenGraph previews
    attachable.variant :open_graph,
                       resize_to_fill: [1200, 630],
                       preprocessed: true

    # Used for product previews in lists
    attachable.variant :thumbnail,
                       resize_to_fill: [240, 192],
                       preprocessed: true

    # Used for product previews in cards
    attachable.variant :medium,
                       resize_to_fill: [400, 300],
                       preprocessed: true

    # Used for biggest picture on product page
    attachable.variant :large,
                       resize_to_fill: [1600, 1200],
                       preprocessed: true
  end
end
