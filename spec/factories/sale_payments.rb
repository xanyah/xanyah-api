# frozen_string_literal: true

FactoryBot.define do
  factory :sale_payment do
    total_amount_cents { rand(0..100) }
    total_amount_currency { 'EUR' }
    sale
    payment_type { build(:payment_type, store: sale&.store) }
  end
end
