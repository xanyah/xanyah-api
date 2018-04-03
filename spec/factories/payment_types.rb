# frozen_string_literal: true

FactoryBot.define do
  factory :payment_type do
    name { Faker::Currency.name }
    description { Faker::Lorem.paragraph }
    store
  end
end
