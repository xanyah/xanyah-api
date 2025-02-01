# frozen_string_literal: true

class Order < ApplicationRecord
  include Order::StateMachine

  belongs_to :customer, optional: false
  belongs_to :store, optional: false

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  accepts_nested_attributes_for :order_products, allow_destroy: true
end
