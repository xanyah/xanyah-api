# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_product do
    shipping
    product
    quantity { rand(1..25) }
  end
end
