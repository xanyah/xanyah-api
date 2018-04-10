# frozen_string_literal: true

FactoryBot.define do
  factory :order_variant do
    order
    variant { build(:variant, store: order&.store) }
    quantity { Faker::Number.number(3) }
  end
end
