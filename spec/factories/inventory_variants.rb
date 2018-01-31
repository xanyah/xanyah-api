# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_variant do
    quantity { Faker::Number.number(3) }
    inventory
    variant
  end
end
