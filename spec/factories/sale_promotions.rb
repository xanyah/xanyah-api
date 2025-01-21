# frozen_string_literal: true

FactoryBot.define do
  factory :sale_promotion do
    type { SalePromotion.types.keys.sample }
    amount_cents { rand(1..100) }
    amount_currency { 'EUR' }
    sale
  end
end
