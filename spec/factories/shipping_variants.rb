# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_variant do
    quantity { Faker::Number.number(3) }
    shipping
    variant
  end
end
