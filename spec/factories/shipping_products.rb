# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_product do
    shipping
    product { build(:product, store: shipping.store) }
    quantity { rand(1..25) }
  end
end
