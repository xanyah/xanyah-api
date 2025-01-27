# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Beer.name }
    sequence :sku do |n|
      n.to_s.rjust(10, '0')
    end

    store

    category { build(:category, store: store) }
    manufacturer { build(:manufacturer, store: store) }
    provider { build(:provider, store: store) }
  end
end
