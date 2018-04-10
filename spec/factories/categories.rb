# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Beer.style }
    tva { Category.tvas.keys.sample }
    store
  end
end
