FactoryBot.define do
  factory :store do
    key {Faker::Internet.domain_word}
    name {Faker::StarWars.planet}
    address {Faker::Address.street_address}
    country {ISO3166::Country.all.map(&:alpha2).sample}
  end
end
