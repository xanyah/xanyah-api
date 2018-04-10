# frozen_string_literal: true

FactoryBot.define do
  factory :vat_rate do
    country_code { Faker::Address.country_code }
    country_name { Faker::Address.country }
    standard_rate { Faker::Number.decimal(2) }
    reduced_rate { Faker::Number.decimal(2) }
    reduced_rate_alt { Faker::Number.decimal(2) }
    super_reduced_rate { Faker::Number.decimal(2) }
    parking_rate { Faker::Number.decimal(2) }
  end
end
