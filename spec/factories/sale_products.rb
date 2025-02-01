# frozen_string_literal: true

FactoryBot.define do
  factory :sale_product do
    sale
    product

    amount { product.amount }
  end
end
