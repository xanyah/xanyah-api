# frozen_string_literal: true

FactoryBot.define do
  factory :sale_variant_promotion do
    type { SaleVariantPromotion.types.keys.sample }
    amount_cents { rand(1..100) }
    amount_currency { 'EUR' }
    sale_variant
  end
end
