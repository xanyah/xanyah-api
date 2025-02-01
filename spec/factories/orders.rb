# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    state { :pending }
    customer
    store
  end
end
