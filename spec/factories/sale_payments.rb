# frozen_string_literal: true

FactoryBot.define do
  factory :sale_payment do
    total_amount_cents { rand(0..100) }
    total_amount_currency { 'EUR' }
    payment_type
    sale { create(:sale, store: payment_type&.store) }
  end
end
