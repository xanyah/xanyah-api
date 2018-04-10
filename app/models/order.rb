# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: %i[
    pending
    delivered
    canceled
  ]

  belongs_to :client, optional: false
  belongs_to :store, optional: false

  has_many :order_variants, dependent: :destroy

  def self.full_creation(params)
    Order.new(
      store_id:  params[:store_id],
      client_id: params[:client_id],
      order_variants: params[:order_variants].map do |ov|
        OrderVariant.new(
          quantity:   ov[:quantity],
          variant_id: ov[:variant_id]
        )
      end
    )
  end
end
