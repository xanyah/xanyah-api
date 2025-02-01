# frozen_string_literal: true

FactoryBot.define do
  factory :shipping do
    state { :pending }
    store
    provider { build(:provider, store:) }
  end
end
