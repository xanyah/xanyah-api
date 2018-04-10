# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :store, optional: false
  belongs_to :user, optional: false

  has_many :sale_payments, dependent: :destroy
  has_many :sale_variants, dependent: :destroy

  def self.full_creation(params, user)
    Sale.new(
      store_id:  params[:store_id],
      user:      user,
      client_id: params[:client_id],
      sale_variants: params[:sale_variants].map { |sv|
        SaleVariant.new(
          quantity:   sv[:quantity],
          unit_price: sv[:unit_price],
          variant_id: sv[:variant_id]
        )
      },
      sale_payments: params[:sale_payments].map { |sp|
        SalePayment.new(
          payment_type_id: sp[:payment_type_id],
          total:           sp[:total]
        )
      }
    )
  end
end