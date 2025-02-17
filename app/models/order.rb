# frozen_string_literal: true

class Order < ApplicationRecord
  include Order::StateMachine

  belongs_to :customer, optional: false
  belongs_to :store, optional: false

  validates_ownership_of :customer, with: :store

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :created_at,
            absence: true,
            unless: proc { |s| s.store&.is_import_enabled? },
            on: :create
end
