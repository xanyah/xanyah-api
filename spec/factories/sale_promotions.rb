# frozen_string_literal: true

FactoryBot.define do
  factory :sale_promotion do
    type {SalePromotion.types.keys.sample}
    amount { rand(1..100) / 10 }
    sale
  end
end
