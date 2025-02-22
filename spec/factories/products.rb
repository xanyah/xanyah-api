# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Beer.name }
    sequence :sku do |n|
      n.to_s.rjust(10, '0')
    end
    amount_cents { rand(1..1000) * 100 }
    amount_currency { 'EUR' }
    tax_free_amount_cents { amount_cents * 0.8 }
    tax_free_amount_currency { amount_currency }
    buying_amount_cents { amount_cents * 0.7 }
    buying_amount_currency { amount_currency }
    quantity { rand(0..10) }

    store

    category { build(:category, store:) }
    manufacturer { build(:manufacturer, store:) }
    vat_rate { VatRate.first }
  end
end
