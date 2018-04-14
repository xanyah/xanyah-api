# frozen_string_literal: true

FactoryBot.define do
  factory :sale_variant_promotion do
    type {SaleVariantPromotion.types.keys.sample}
    amount { rand(1..100).to_f / 10 }
    sale_variant
  end
end
