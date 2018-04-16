# frozen_string_literal: true

FactoryBot.define do
  factory :sale_variant do
    quantity { rand(0..200) }
    unit_price { Faker::Number.decimal(2) }

    sale
    variant { build(:variant, store: sale&.store) }
  end
end
