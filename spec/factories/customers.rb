# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    notes { Faker::Lorem.paragraph }
    store
  end
end
