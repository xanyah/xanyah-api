# frozen_string_literal: true

class Shipping < ApplicationRecord
  include Shipping::StateMachine

  belongs_to :provider, optional: false
  belongs_to :store, optional: false
  has_many :shipping_products, dependent: :destroy

  accepts_nested_attributes_for :shipping_products, allow_destroy: true
end
