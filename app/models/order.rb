# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { pending: 0, delivered: 1, canceled: 2 }

  belongs_to :client, optional: false
  belongs_to :store, optional: false

  has_many :order_variants, dependent: :destroy
  has_many :variants, through: :order_variants
  has_many :products, through: :variants

  def self.full_creation(params)
    Order.new(
      store_id: params[:store_id],
      client_id: params[:client_id],
      order_variants: params[:order_variants].map do |ov|
        OrderVariant.new(
          quantity: ov[:quantity],
          variant_id: ov[:variant_id]
        )
      end
    )
  end

  def self.search(query)
    query = query.downcase
    left_outer_joins(:client).left_outer_joins(:products).where("
      LOWER(clients.firstname) LIKE ?
      OR LOWER(clients.lastname) LIKE ?
      OR LOWER(products.name) LIKE ?
    ", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
