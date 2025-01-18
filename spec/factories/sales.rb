# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    total_price { Faker::Number.decimal(l_digits: 2) }

    store
    user
    client
  end
end
