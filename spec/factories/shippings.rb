# frozen_string_literal: true

FactoryBot.define do
  factory :shipping do
    locked_at { nil }
    store
    provider
  end
end
