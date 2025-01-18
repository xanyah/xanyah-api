# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :store, optional: false
  belongs_to :user, optional: false

  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_one :sale_promotion, dependent: :destroy

  has_many :sale_payments, dependent: :destroy
  has_many :sale_variants, dependent: :destroy
  has_many :variants, through: :sale_variants

  def self.full_creation(params, user) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    sale = Sale.new(
      total_price: params[:total_price],
      store_id: params[:store_id],
      user: user,
      client_id: params[:client_id],
      sale_variants: params[:sale_variants].map do |sv|
        variant = SaleVariant.new(
          quantity: sv[:quantity],
          unit_price: sv[:unit_price],
          variant_id: sv[:variant_id]
        )
        if sv[:sale_variant_promotion].present?
          variant.sale_variant_promotion = SaleVariantPromotion.new(
            type: sv[:sale_variant_promotion][:type],
            amount: sv[:sale_variant_promotion][:amount]
          )
        end
        variant
      end,
      sale_payments: params[:sale_payments].map do |sp|
        SalePayment.new(
          payment_type_id: sp[:payment_type_id],
          total: sp[:total]
        )
      end
    )
    if params[:sale_promotion].present?
      sale.sale_promotion = SalePromotion.new(
        type: params[:sale_promotion][:type],
        amount: params[:sale_promotion][:amount]
      )
    end
    sale
  end
end
