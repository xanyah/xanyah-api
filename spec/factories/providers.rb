# frozen_string_literal: true

FactoryBot.define do
  factory :provider do
    name { Faker::TvShows::RickAndMorty.character }
    notes { Faker::Address.street_address }
    store
  end
end
