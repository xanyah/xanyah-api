# frozen_string_literal: true

FactoryBot.define do
  factory :vat_rate do
    country_code 'MyString'
    country_name 'MyString'
    standard_rate 1.5
    reduced_rate 1.5
    reduced_rate_alt 1.5
    super_reduced_rate 1.5
    parking_rate 1.5
  end
end
