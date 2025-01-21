# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    name { Faker::Movies::StarWars.planet }
    sequence :key do |n|
      "#{name.parameterize}-#{n}"
    end
    address { Faker::Address.street_address }
    country { Country.first || build(:country) }
  end
end
