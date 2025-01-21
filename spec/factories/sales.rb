# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    total_amount_cents { rand(0..100) }
    total_amount_currency { 'eur' }

    store
    user
    client
  end
end
