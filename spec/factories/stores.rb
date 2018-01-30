FactoryBot.define do
  factory :store do
    name {Faker::StarWars.planet}
    sequence :key {|n| "#{name.to_slug}-#{n}" }
    address {Faker::Address.street_address}
    country {ISO3166::Country.all.map(&:alpha2).sample}
  end
end
