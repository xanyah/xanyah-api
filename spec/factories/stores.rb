FactoryBot.define do
  factory :store do
    name {Faker::StarWars.planet}
    key {name.to_slug}
    address {Faker::Address.street_address}
    country {ISO3166::Country.all.map(&:alpha2).sample}
  end
end
