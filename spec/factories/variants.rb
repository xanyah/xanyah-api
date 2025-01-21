# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    original_barcode { Faker::Number.number(digits: 10).to_s }
    buying_amount_cents { rand(1..100) }
    buying_amount_currency { 'eur' }
    default { false }
    ratio { rand(1..20).to_f / 10 }
    tax_free_amount_cents { (buying_amount_cents * ratio) }
    tax_free_amount_currency { 'eur' }
    product
    provider

    trait :as_params do
      product_id { create(:product).id }
      provider_id { create(:provider).id }
    end
  end
end
