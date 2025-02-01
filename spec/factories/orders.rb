# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    state { :pending }
    store
    customer { build(:customer, store:) }
  end
end
