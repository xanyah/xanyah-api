# frozen_string_literal: true

FactoryBot.define do
  factory :order_product do
    order
    product { build(:product, store: order.store) }
    quantity { rand(1..25) }
  end
end
