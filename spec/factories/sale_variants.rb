# frozen_string_literal: true

FactoryBot.define do
  factory :sale_variant do
    quantity { rand(0..200) }
    amount_cents { rand(0..100) }
    amount_currency { 'EUR' }

    sale
    variant { build(:variant, store: sale&.store) }
  end
end
