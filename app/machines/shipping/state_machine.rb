# frozen_string_literal: true

class Shipping
  module StateMachine
    extend ActiveSupport::Concern

    included do
      include AASM

      aasm column: :state, timestamps: true do
        state :pending, initial: true
        state :validated
        state :cancelled

        event :validate, before: :insert_products do
          transitions from: %i[pending cancelled], to: :validated
        end

        event :cancel, before: :extract_products do
          transitions from: :validated, to: :cancelled
        end
      end

      def insert_products
        shipping_products.each do |shipping_product|
          shipping_product.product.update(quantity: shipping_product.product.quantity + shipping_product.quantity)
        end
      end

      def extract_products
        shipping_products.each do |shipping_product|
          shipping_product.product.update(quantity: shipping_product.product.quantity - shipping_product.quantity)
        end
      end
    end
  end
end
