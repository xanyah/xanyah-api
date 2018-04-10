# frozen_string_literal: true

FactoryBot.define do
  factory :sale_payment do
    total { Faker::Number.decimal(2) }
    sale
    payment_type
  end
end
