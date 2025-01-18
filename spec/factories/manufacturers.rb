# frozen_string_literal: true

FactoryBot.define do
  factory :manufacturer do
    name { Faker::Movies::HarryPotter.character }
    notes { Faker::Address.street_address }
    store
  end
end
