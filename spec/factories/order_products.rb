# frozen_string_literal: true

FactoryBot.define do
  factory :order_product do
    order
    product
    quantity { rand(1..25) }
  end
end
